class NeuralNetwork
  def initialize
   @network = {
    input: {
      bias_plural: {b0: rand, b1: rand}
    },
    edges_input_hl1: {
     weights: { w0_0: rand, w0_1: rand, w0_2: rand, w1_0: rand, w1_1: rand, w1_2: rand } 
    },
    hidden_layer_1: {
     bias_plural: {b0: rand, b1: rand, b2: rand}
    },
    edges_hl1_output: {
     weights: { w0_0: rand, w0_1: rand, w1_0: rand, w1_1: rand, w2_0: rand, w2_1: rand } 
    },
    output: {
     bias_plural: {b0: rand, b1: rand}
    }
   }


   @selection_of_parameters_for_learning_iteration = [
     :iB1, :iB2,
     :eihW1, :eihW2, :eihW3, eihW4, :eihW5, :eihW6,
     :hB1, :hB2, :hB3,
     :ehoW1, :ehoW2, :ehoW3, ehoW4, :ehoW5, :ehoW6,
     :oB1, :oB2 
   ]
  end


  def visualize_network
  end
  

  def output(input)
   x0 = input[0] + @network[:input][:bias_plural][:b0]
   x1 = input[0] + @network[:input][:bias_plural][:b1]


   hx0_0 = x0 * edges_input_hl1[:weights][:w0_0] + hidden_layer_1[:bias_plural][:b0]
   hx0_1 = x0 * edges_input_hl1[:weights][:w0_1] + hidden_layer_1[:bias_plural][:b1]
   hx0_2 = x0 * edges_input_hl1[:weights][:w0_2] + hidden_layer_1[:bias_plural][:b2]

   hx1_0 = x0 * edges_input_hl1[:weights][:w1_0] + hidden_layer_1[:bias_plural][:b0]
   hx1_1 = x0 * edges_input_hl1[:weights][:w1_1] + hidden_layer_1[:bias_plural][:b1]
   hx1_2 = x0 * edges_input_hl1[:weights][:w1_2] + hidden_layer_1[:bias_plural][:b2]


   h1_0 = activation_h1_0(hx0_0, hx1_0)
   h1_1 = activation_h1_1(hx0_1, hx1_1)
   h1_2 = activation_h1_2(hx0_2, hx1_2)
  end


  def learn(error)
    if last_selection_of_parameters_no_more_gains?(error)
      @learn_those_parameters = @selection_of_parameters_for_learning_iteration.sample(4)
    end
    

    alter_parameters(error)(@learn_those_parameters)
  end


  def alter_parameters(error)
   return lambda do |parameters|
     parameter_learning_rates[parameters]
   end
  end
end
