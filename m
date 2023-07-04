Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E246746A96
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jul 2023 09:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjGDH1D (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Jul 2023 03:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjGDH1C (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Jul 2023 03:27:02 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13CAE64
        for <linux-spi@vger.kernel.org>; Tue,  4 Jul 2023 00:27:00 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51d91e9b533so5835662a12.3
        for <linux-spi@vger.kernel.org>; Tue, 04 Jul 2023 00:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688455619; x=1691047619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QLvC9yQweP2jkj/z5ky3qI3WCyWJokyxqUpHyykqNaI=;
        b=dScqnoh2VPDqBKJONRB3XpJ1J4rJu/mAae6etUwxhZfGxxAWQNshujuG7kOgt3rgWj
         0wvboQ9olapoLdBDLwon0hvo16jzs+OjrHkfxs8yGUKKwD75orI2GQlGFc679CEoo/fP
         6Cx9r2MFI5A3J+yBX748fdJvJN1dhHJoSB83j5wXHtp+d2u074G7qf0B215+Fbo21WwV
         pZnKfpbGRYR7exy3HbR0Rnyb1o1sB6oeWJRqFWsMNFfCyg90yZjjP6mUNkTR5Iw6nS+4
         98pkJn61VUoRcxtIn5CM2CLpEMSmMkWG8vp/iHwJzhrh561MZ7TbamH/opsN8qqjL/b3
         Ztag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688455619; x=1691047619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QLvC9yQweP2jkj/z5ky3qI3WCyWJokyxqUpHyykqNaI=;
        b=fdozH+gbznGKgm+l7HcGY4zGMX0uBwaioMmyXG5XY6z3BXnBU2g82Vxi3jyICoI78g
         /Qje+Ri/5gr8I8LT1vlf0jUO75/YRjL1S+Ac3ODCFurmrQ7/pSbSnb5c3/DwQHjTyljK
         992fslOPPX4OmjxH52iL5htFKEH4BC+qVPEpzSoACcDdR4KGCsAQuhG0OD+s0gCmt5qN
         llafR+lP1rKI1WaTNGzXg/ql3tiMfkL02WBXfdNRutK8StI0fAXolTnf9BSx33H3nbTY
         FWINoChzfKQ/wo3ghy8GXY65FdIMvFqtsYcpTSflu8oiTmaXZYUgz8eX2CzVcRxl9KSc
         yQgg==
X-Gm-Message-State: ABy/qLa0D5pr+FZ/0b9Q/VvYCdZS59UrJsWDQr4/T1KH4dRNab7R861/
        MgygoNte4JUIopGhzax6ExSP7A==
X-Google-Smtp-Source: APBJJlE1IjKvDarNtUBjzLVv9CQsL1HkuWTRmLzOr9Pi+q5K3MYpKA7ovY5SMabOhBfH26zcZM9irA==
X-Received: by 2002:aa7:d98e:0:b0:518:721e:f594 with SMTP id u14-20020aa7d98e000000b00518721ef594mr9239580eds.37.1688455619445;
        Tue, 04 Jul 2023 00:26:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id k12-20020aa7d8cc000000b0051e22660835sm441945eds.46.2023.07.04.00.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 00:26:59 -0700 (PDT)
Message-ID: <9f359dd2-4d56-d4a6-779c-4298b7f029d9@linaro.org>
Date:   Tue, 4 Jul 2023 09:26:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/4] dt-bindings: interconnect: qcom,sm8250: Add QUP
 virt
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Sibi Sankar <sibis@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230703-topic-8250_qup_icc-v2-0-9ba0a9460be2@linaro.org>
 <20230703-topic-8250_qup_icc-v2-2-9ba0a9460be2@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230703-topic-8250_qup_icc-v2-2-9ba0a9460be2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 03/07/2023 22:15, Konrad Dybcio wrote:
> Add the required defines for QUP_virt nodes.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

