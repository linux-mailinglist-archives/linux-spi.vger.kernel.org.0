Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4C966E399
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jan 2023 17:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjAQQdV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Jan 2023 11:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjAQQdT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Jan 2023 11:33:19 -0500
Received: from mail.zeus06.de (www.zeus06.de [194.117.254.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC11402E2
        for <linux-spi@vger.kernel.org>; Tue, 17 Jan 2023 08:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=kicherer.org; h=
        mime-version:date:from:to:cc:subject:in-reply-to:references
        :message-id:content-type:content-transfer-encoding; s=k1; bh=IHn
        ViGA1fZxggB+CRxZmijTldMspCftvfTlEyIlaVPo=; b=kRTfQAdS1ZItUFnr128
        cJlKVMLPSFs9cypOM7Wzrowp2wG8VjcDRzs5bw2SaTbWcnEa8HfgxfhxqrkzCVF8
        JKb3Fk6V4RJyQVwVKbAEKhEL3aoD1nIY4HZ/zNWL2nu5t2+sWvuo8YukjFvClYfE
        gTEgGluS0NpLVGqmn848Z2Zk=
Received: (qmail 1176974 invoked from network); 17 Jan 2023 17:33:16 +0100
Received: by mail.zeus06.de with ESMTPA; 17 Jan 2023 17:33:16 +0100
X-UD-Smtp-Session: l3s6476p2@OdfAQXjy6rbCdf4e
MIME-Version: 1.0
Date:   Tue, 17 Jan 2023 17:33:16 +0100
From:   Mario Kicherer <dev@kicherer.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-spi@vger.kernel.org, han.xu@nxp.com, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-fsl-qspi: add optional
 sampling-delay
In-Reply-To: <20230117141057.GA2991740-robh@kernel.org>
References: <20230116115050.2983406-1-dev@kicherer.org>
 <20230116115050.2983406-2-dev@kicherer.org>
 <20230117141057.GA2991740-robh@kernel.org>
Message-ID: <85967a3fbce7051449f8d2b29ce5a47c@kicherer.org>
X-Sender: dev@kicherer.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

unfortunately, the rx-sample-delay-ns property does not fit here, as we 
can only delay
the sampling point between zero and three "half cycles" (or edges), not 
by an arbitrary
number of nanoseconds.

Regarding the bot message, I do not understand what is wrong in my 
patch. I found similar
property descriptions in other files and also in the official doc [1] 
there is an equal
(to me) example under "clock-frequency", if I am not missing something.

Thank you for the review!

Best regards,
Mario

[1] https://docs.kernel.org/devicetree/bindings/writing-schema.html

On 2023-01-17 15:10, Rob Herring wrote:
> On Mon, Jan 16, 2023 at 12:50:49PM +0100, Mario Kicherer wrote:
>> Add optional sampling-delay property to delay the internal sampling 
>> point for
>> incoming data.
>> 
>> Signed-off-by: Mario Kicherer <dev@kicherer.org>
>> ---
>>  Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml | 6 
>> ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml 
>> b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
>> index e58644558412..7952a4be938b 100644
>> --- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
>> @@ -54,6 +54,12 @@ properties:
>>        - const: qspi_en
>>        - const: qspi
>> 
>> +  fsl,qspi-sampling-delay:
>> +    description: delay sampling of incoming data by this number of 
>> half cycles
> 
> Use the common rx-sample-delay-ns property.
> 
>> +    minimum: 0
>> +    maximum: 3
>> +    default: 0
>> +
>>  required:
>>    - compatible
>>    - reg
>> --
>> 2.34.1
>> 
