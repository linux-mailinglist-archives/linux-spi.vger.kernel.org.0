Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B269F561565
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jun 2022 10:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbiF3Iq4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Jun 2022 04:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiF3Iqz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Jun 2022 04:46:55 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5A040A2F
        for <linux-spi@vger.kernel.org>; Thu, 30 Jun 2022 01:46:54 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id pk21so37642650ejb.2
        for <linux-spi@vger.kernel.org>; Thu, 30 Jun 2022 01:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ijUWiZS99qlF/8rRWRrspTyoZo9W1oBwhdsM2NPK7es=;
        b=LSQDYNqaVAhiuyHrnxLSnNa4KYDv5v3ZdaOXu5gMU1DNOz4x+YfG+VbjZ3A2gl6eCZ
         L11gg0aPuodv4gHEIQZvv3w7UoafvFp6QSMCORZOtk7LrTMXRgd4SVEOEyhEZGy/K+N5
         UZl3y/Q5imBi7T/+mmSKMxsAc6rGkfi9cr/GMX0htQFoC3J+GglHPNgqtaHaKYDlR0Jd
         /wphyRmcQdqDgvehLCcuADzaIjxjTvPL6CA6lxIli1waynFegdrl7RFXasXziwn+ObtA
         pa6ahDmX1+PUTGkwA1bOn8GKu6RQZ8ySt3LcCn80K5U/jGZqsgQShDYkkfrrF++6AwhR
         JVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ijUWiZS99qlF/8rRWRrspTyoZo9W1oBwhdsM2NPK7es=;
        b=DgzaVteXLeXihGORqU/e1IXNYiZonzRlxFTn27Bk+9jzSIWmoxoe7pMoL/6SNGA9Cy
         HSigO0lgB6TR1Vc48T6t0mchl7l0QyxaJ2VECQr5Oeer81W+0zZnBAynv18TWhgvnNdw
         O3AJ8EKX1fWsC8hzYYlZcN1CWsZ+jBBuVQ6thblMnwmvhJVPbJFs1lRFE9HiCF0UjfuI
         xhogXXSDozJwGB4Q/fH/evS9PhehYhTn0bD5WMXxbwdna44lfFu3/hHK6L1Vpg1f7WOQ
         q6YHb/Tj9lFrHgAfWU92e6CRdZozzbl4ut5MRzVFRhBOxOox9/xJOP0v4RpsSG5WH7cK
         d0pg==
X-Gm-Message-State: AJIora+iXUufT24ETRmyMbG3TBfPBdatLRHB8S41LmID695fIO+tSNf1
        b2TmwVwumB5yZSn22qETkV3qmw==
X-Google-Smtp-Source: AGRyM1snFeJioxa+M3t6BLa7YLUALZZi9c8Py51mZRv9MEGq2s62WIPMl6nK5TS4PB5kSwACpnzQew==
X-Received: by 2002:a17:907:6e1e:b0:726:be5e:7130 with SMTP id sd30-20020a1709076e1e00b00726be5e7130mr7902698ejc.381.1656578812745;
        Thu, 30 Jun 2022 01:46:52 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id hx23-20020a170906847700b00722e84c3d44sm8711679ejc.118.2022.06.30.01.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 01:46:52 -0700 (PDT)
Message-ID: <2df6673b-6f8d-19c2-90ca-342e3ba72040@linaro.org>
Date:   Thu, 30 Jun 2022 10:46:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 6/7] memory: renesas-rpc-if: Pass device instead of rpcif
 to rpcif_*()
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1656341824.git.geert+renesas@glider.be>
 <e313b7f9a856fd8546aabb20d44d10e3af6676c6.1656341824.git.geert+renesas@glider.be>
 <20220630092552.68a8b3ff@xps-13>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220630092552.68a8b3ff@xps-13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 30/06/2022 09:25, Miquel Raynal wrote:
> Hi Krzysztof,
> 
> geert+renesas@glider.be wrote on Mon, 27 Jun 2022 17:31:13 +0200:
> 
>> Most rpcif_*() API functions do not need access to any other fields in
>> the rpcif structure than the device pointer.  Simplify dependencies by
>> passing the device pointer instead.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  drivers/memory/renesas-rpc-if.c | 32 ++++++++++++++++----------------
>>  drivers/mtd/hyperbus/rpc-if.c   | 18 +++++++++---------
> 
> [...]
> 
>> diff --git a/drivers/mtd/hyperbus/rpc-if.c b/drivers/mtd/hyperbus/rpc-if.c
>> index d00d302434030b20..41734e337ac00e40 100644
>> --- a/drivers/mtd/hyperbus/rpc-if.c
>> +++ b/drivers/mtd/hyperbus/rpc-if.c
>> @@ -56,7 +56,7 @@ static void rpcif_hb_prepare_read(struct rpcif *rpc, void *to,
>>  	op.data.nbytes = len;
>>  	op.data.buf.in = to;
>>  
>> -	rpcif_prepare(rpc, &op, NULL, NULL);
>> +	rpcif_prepare(rpc->dev, &op, NULL, NULL);
>>  }
>>  
>>  static void rpcif_hb_prepare_write(struct rpcif *rpc, unsigned long to,
>> @@ -70,7 +70,7 @@ static void rpcif_hb_prepare_write(struct rpcif *rpc, unsigned long to,
>>  	op.data.nbytes = len;
>>  	op.data.buf.out = from;
>>  
>> -	rpcif_prepare(rpc, &op, NULL, NULL);
>> +	rpcif_prepare(rpc->dev, &op, NULL, NULL);
>>  }
>>  
>>  static u16 rpcif_hb_read16(struct hyperbus_device *hbdev, unsigned long addr)
>> @@ -81,7 +81,7 @@ static u16 rpcif_hb_read16(struct hyperbus_device *hbdev, unsigned long addr)
>>  
>>  	rpcif_hb_prepare_read(&hyperbus->rpc, &data, addr, 2);
>>  
>> -	rpcif_manual_xfer(&hyperbus->rpc);
>> +	rpcif_manual_xfer(hyperbus->rpc.dev);
>>  
>>  	return data.x[0];
>>  }
>> @@ -94,7 +94,7 @@ static void rpcif_hb_write16(struct hyperbus_device *hbdev, unsigned long addr,
>>  
>>  	rpcif_hb_prepare_write(&hyperbus->rpc, addr, &data, 2);
>>  
>> -	rpcif_manual_xfer(&hyperbus->rpc);
>> +	rpcif_manual_xfer(hyperbus->rpc.dev);
>>  }
>>  
>>  static void rpcif_hb_copy_from(struct hyperbus_device *hbdev, void *to,
>> @@ -105,7 +105,7 @@ static void rpcif_hb_copy_from(struct hyperbus_device *hbdev, void *to,
>>  
>>  	rpcif_hb_prepare_read(&hyperbus->rpc, to, from, len);
>>  
>> -	rpcif_dirmap_read(&hyperbus->rpc, from, len, to);
>> +	rpcif_dirmap_read(hyperbus->rpc.dev, from, len, to);
>>  }
>>  
>>  static const struct hyperbus_ops rpcif_hb_ops = {
>> @@ -130,9 +130,9 @@ static int rpcif_hb_probe(struct platform_device *pdev)
>>  
>>  	platform_set_drvdata(pdev, hyperbus);
>>  
>> -	rpcif_enable_rpm(&hyperbus->rpc);
>> +	rpcif_enable_rpm(hyperbus->rpc.dev);
>>  
>> -	error = rpcif_hw_init(&hyperbus->rpc, true);
>> +	error = rpcif_hw_init(hyperbus->rpc.dev, true);
>>  	if (error)
>>  		goto out_disable_rpm;
>>  
>> @@ -150,7 +150,7 @@ static int rpcif_hb_probe(struct platform_device *pdev)
>>  	return 0;
>>  
>>  out_disable_rpm:
>> -	rpcif_disable_rpm(&hyperbus->rpc);
>> +	rpcif_disable_rpm(hyperbus->rpc.dev);
>>  	return error;
>>  }
> 
> This will only apply on top of mtd/next, because that
> rpcif_disable_rpm() balance call was very recently contributed by Geert:
> https://lore.kernel.org/linux-mtd/f3070e1af480cb252ae183d479a593dbbf947685.1655457790.git.geert+renesas@glider.be/
> 
> So we need to first share an immutable tag on the current mtd/next
> branch. Richard, that is my vacation gift for you :)

I don't want entire mtd/next. I could take Renesas hyperbus specific
commits. Another solution is me to rebase on some rcX, if that commit
was sent as fix for current cycle.
The third option is to simply resolve a conflict - which should looks
pretty easy and compile-testable. In that case the commit should be
rebased on my v5.19-rc1.

Best regards,
Krzysztof
