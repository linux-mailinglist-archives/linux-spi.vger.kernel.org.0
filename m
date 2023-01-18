Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5A167168B
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jan 2023 09:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjARIwM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Jan 2023 03:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjARIsf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Jan 2023 03:48:35 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011E4392BF;
        Wed, 18 Jan 2023 00:02:10 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id AC0D0D5D;
        Wed, 18 Jan 2023 09:02:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1674028927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q4LtkWQwj+s5wRr9ftmaGPFVQWqkH/zbHMQ6iAuaZCk=;
        b=KzMwo29z2YN5Fh3BND3jQ1EzGgDVcfwgB43ZKWFNqdLmMRudSFoliRpzicnJQPrnkCW8Ha
        Kjyq3ICId+Gzeg1VMP+/AZ/NAsEZOa7RBIzUFt74X2scq2ycM/HJJO6ezCVZ4c5lswoYXo
        bRyAa7FiBncPohpKUxD0j5sd3TlXJBZ1vBjbpaqfVcxSLIUVSmI+NnsontrtuUBdqHg76I
        kYcgVoegHfDMhshDekkkZ5a0LHCZRRR21imc3tSZXkFMx/0+BdVjRiMvHRFq3KVPk4umgX
        fm8x+yq2/bG11dNCIDi7Iol7aoa1dap05dCnFr3ucEGPZI2kZ4IyJfcY8cWrBA==
From:   Michael Walle <michael@walle.cc>
To:     han.xu@nxp.com
Cc:     broonie@kernel.org, dev@kicherer.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-spi@vger.kernel.org, robh@kernel.org, michael@walle.cc
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-fsl-qspi: add optional sampling-delay
Date:   Wed, 18 Jan 2023 09:01:59 +0100
Message-Id: <20230118080159.112295-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230117210500.oimf4yjkkqh3o4hi@umbrella>
References: <20230117210500.oimf4yjkkqh3o4hi@umbrella>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: "han.xu" <han.xu@nxp.com>

Hi,

>>> unfortunately, the rx-sample-delay-ns property does not fit here, as we 
>>> can only delay
>>> the sampling point between zero and three "half cycles" (or edges), not 
>>> by an arbitrary
>>> number of nanoseconds.
>> 
>> Why this is a problem for FSL but not for other platforms having exactly
>> the same constraints/property?
>
> Please use the common delay in DT and calculate to half cycle in driver, we have
> the similar discussion before for fspi controller delay settings.

Do you mean [1]? There my suggestion was to use a -degrees property (because
it doesn't depend on the frequency). There wasn't any follow-up, or did I miss
something?

-michael

[1] https://lore.kernel.org/linux-spi/62f113a0cdb0d58bf04ab0b274912eb7@walle.cc/
