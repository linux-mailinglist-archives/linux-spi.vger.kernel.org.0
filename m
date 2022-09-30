Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF2F5F0969
	for <lists+linux-spi@lfdr.de>; Fri, 30 Sep 2022 13:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiI3LCJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Sep 2022 07:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiI3LBt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Sep 2022 07:01:49 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDB518E6B4
        for <linux-spi@vger.kernel.org>; Fri, 30 Sep 2022 03:39:22 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id t16so4361267ljh.3
        for <linux-spi@vger.kernel.org>; Fri, 30 Sep 2022 03:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=o/F++oFIQSCNgyoWQTHuIwKG1EZOW//JzkCJxSjLwAU=;
        b=rxb4CQTw3Zc+y8uPfy/BUeh8y51Ef6nFZE9/VR+JXPEg/7aAQ5/dhD9XZOnbNCrIiD
         OPUjTe/tbV357qEDvohmxfY3dLSMS+n9aS4rSa6phEK38ZLza0d+EDcbxrYXCCT1RePP
         eTJPVvtbIDQf0Tz+dKnsBXRKnAk1Z1q2zRzAqA+HdrkUtCfnMCjRJ/7nkCqreNTP4zzx
         wuL7ct3NMG8kSHDiRh1iov3hH/PW6bYcoMira2nM7Ak/8QpdSkQmH5j/MY9C4abmePry
         snlvoMsH88GRSZJOE1MVvH8jylb87xYLNdrWjQjLOxzNAnaKkV6yOTQdDMUSOmSohvKu
         MklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=o/F++oFIQSCNgyoWQTHuIwKG1EZOW//JzkCJxSjLwAU=;
        b=RrSALNc9bQZ4EI9jcb/V0QSnge4vVsvXU9j3dacMi+CwnDxj84qw5c/wsOI0Zm+EHJ
         QZsJp8RZDSYxtvU7jW1wrn4VuQuPB8amGxOWmpxAKw0JWbWPV0JKodEeb6OXxGVXWmt8
         EnjjpccxSq5SW6yKiCcYPw7QCjnjDSECLHvpWcvPWE0bvJIaN5abBR0Vpx5vlJPPEDxM
         Lw3qx+6pNHuqHCClwjzAyCDeLP8Tr4d6Kvysm4FapmaQwxZT9duN0SNEsfIql3fi9zrm
         fDW568+iwKy9ngSQ/lGM/QBP0SmZUzvm92XhLGSTXlv+6boA+lYH4JrneXZY45chcQCW
         mq5A==
X-Gm-Message-State: ACrzQf0PwcbKFhwuwN317rRWRty0hvEVpo8PkcjSGafC9LrowcjxtmyN
        /NTsKtMx+SxAd+V3TZeeVxbaTUTj5ayvSg==
X-Google-Smtp-Source: AMsMyM5fGF7ZqGZM/+/VFntmJYF8LF72jC8heZQA/Ci8FdoGcZxisWNrHh99UdNFmrHPRWSU+f7dnQ==
X-Received: by 2002:a05:6512:280b:b0:49b:542a:4fcb with SMTP id cf11-20020a056512280b00b0049b542a4fcbmr3258740lfb.134.1664533781585;
        Fri, 30 Sep 2022 03:29:41 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k21-20020a05651239d500b00497feee98basm245543lfu.274.2022.09.30.03.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 03:29:41 -0700 (PDT)
Message-ID: <2c634eae-1aae-d9e5-6f29-f0b373666aab@linaro.org>
Date:   Fri, 30 Sep 2022 12:29:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: airoha: Add documentation for
 Airoha SPI controller
Content-Language: en-US
To:     Bert Vermeulen <bert@biot.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     John Crispin <john@phrozen.org>,
        Benjamin Larsson <benjamin.larsson@iopsys.eu>
References: <20220927113229.1214224-1-bert@biot.com>
 <20220927113229.1214224-2-bert@biot.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220927113229.1214224-2-bert@biot.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 27/09/2022 13:32, Bert Vermeulen wrote:
> Create documentation for accessing the Airoha EN7523 SPI controller.
> 
> Signed-off-by: Bert Vermeulen <bert@biot.com>

Use subject prefixes matching the subsystem (git log --oneline -- ...).

> ---
>  .../bindings/spi/airoha,en7523-spi.yaml       | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/airoha,en7523-spi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/airoha,en7523-spi.yaml b/Documentation/devicetree/bindings/spi/airoha,en7523-spi.yaml
> new file mode 100644
> index 000000000000..8f4936512a99
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/airoha,en7523-spi.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/airoha,en7523-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha EN7523 SPI controller
> +
> +maintainers:
> +  - Bert Vermeulen <bert@biot.com>
> +
> +description: |
> +  This binding describes the SPI controller on Airoha EN7523 SoCs.
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    items:

Drop "items:" and leading hyphen from line below.

> +      - const: airoha,en7523-spi


Best regards,
Krzysztof

