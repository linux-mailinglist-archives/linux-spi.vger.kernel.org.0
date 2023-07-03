Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98A4745E79
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jul 2023 16:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjGCOZ7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Jul 2023 10:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjGCOZ6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Jul 2023 10:25:58 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C295CE64
        for <linux-spi@vger.kernel.org>; Mon,  3 Jul 2023 07:25:56 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb761efa7aso6973407e87.0
        for <linux-spi@vger.kernel.org>; Mon, 03 Jul 2023 07:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688394355; x=1690986355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nR1JIau5H5rAt0KfiJQqEOPzQsDB3hDcj43jCj7PzkM=;
        b=XFE+lKHhuGUEIXWBw4DftRQl+i6fw+3/N8iyJEyTVXO/98D+spWfUSRMZkOBzRB7XD
         SVy0VcHTVh3QPXv7kxJne6o5fqL3GZiaQFO++JNMFeRepJqynHenV0O034CMh9uoIW98
         3eMoo0trZx4+MaUFqSa4g3yHawk7gA3t/hSkfYiMt2OjtYYCvfYPWSfo6Q9GEVwCym70
         zbuAaKlA+ADuKSHEK1cnjcXRJucspTr5/ZfBpsvtMkMYK7Y82HGwwaRrmeo49u5tu5b7
         Ng30EYNhd/PVblqQP8XZpOJ/xz2DCMyHC8JUj2IION+iBaAl2z/a2PwglkKDZ1kjMh7m
         uJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688394355; x=1690986355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nR1JIau5H5rAt0KfiJQqEOPzQsDB3hDcj43jCj7PzkM=;
        b=O3dOS8c+NcbwAHmJfSMUln6TpxTuYx80S1DYFtdWQ8CAZ3OKX7MkSmFLOc+qbFj+qh
         KvkZD2FpbM71VVdr56KflTncFO97/lFdK8JDOh6ckEW0rRIaIGQ//EtxkWVfyKuzZG49
         RVGNHcP8CCrJjbli7wH124fscHFVEzClXbLGmG7cEuAfuhJsJipBM/Vd3L0yNjhxH//m
         nFIhaZIpnIMfWceRrFawUk06E0Z94OmN0M5oQaE+opjBLswq0NwVmx8OiiTxDAhDhqkR
         oEzlVymgxUzKNXgR9POsmeqSyA+cGDX2e5aH8h2EKKqxuPHlP6+fiUJEvduu4PELMogX
         6zZw==
X-Gm-Message-State: ABy/qLYZNxGxMCSLTZsFxC9rHf+s3jncrV0yJTpp49s9gdjCe+IEJxQS
        FIodoPlH04MXzd4u2Bv9uOuunw==
X-Google-Smtp-Source: APBJJlHM/qj4pCS4sZLl2C1DpzpOgZRb5FHLaQjBC5mgZoHK2+2jKTCEi/ZXgIu5NMvCycfbRNL82A==
X-Received: by 2002:a19:8c1d:0:b0:4f4:b13a:d683 with SMTP id o29-20020a198c1d000000b004f4b13ad683mr6185895lfd.69.1688394354995;
        Mon, 03 Jul 2023 07:25:54 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id v16-20020ac25610000000b004fb763b5171sm3815903lfd.86.2023.07.03.07.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 07:25:54 -0700 (PDT)
Message-ID: <643629e2-0da9-44ac-68bf-1867fad8a9ee@linaro.org>
Date:   Mon, 3 Jul 2023 17:25:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sm8250: Add interconnects and
 power-domains to QUPs
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Shyti <andi.shyti@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20230703-topic-8250_qup_icc-v1-0-fea39aa07525@linaro.org>
 <20230703-topic-8250_qup_icc-v1-5-fea39aa07525@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230703-topic-8250_qup_icc-v1-5-fea39aa07525@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 03/07/2023 16:31, Konrad Dybcio wrote:
> Describe the interconnect paths related to QUPs and add the power-domains
> powering them.
> 
> This is required for icc sync_state, as otherwise QUP access is gated.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8250.dtsi | 150 +++++++++++++++++++++++++++++++++++
>   1 file changed, 150 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

