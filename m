Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639C222AA92
	for <lists+linux-spi@lfdr.de>; Thu, 23 Jul 2020 10:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgGWIWi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 Jul 2020 04:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgGWIWi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 23 Jul 2020 04:22:38 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3593C0619DC;
        Thu, 23 Jul 2020 01:22:37 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id p14so3771910wmg.1;
        Thu, 23 Jul 2020 01:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QE10UDZQ3r5KctDFG038ZVtepXURxKEMA8qw8LlWSEY=;
        b=Os/0wGVhINaT50kNjojm42n5UockuOvesYAtUK3exVVbKcF5f/N0XQJlTarczwHRKU
         uy4WrGbGX1HgDZMJHOdn3+fUrZAGtEXkfou9SSW+pVYhvrjkV2mNzquCZEHE3xVGY5bX
         yb8pittSkp1e5A7ZkSg9Y0HFp6327SPU3I6nl0kxxOUfWE3jePiiSvpBvwpvjKVJKel/
         kTZsuoKzZsMGOPRrf49CbzEGxqQbmm04QK+emJHbt/jYHbzENz/h8MGC9vyIFLZOOhFJ
         S5/Oh3RUNtI9ver6zN0JtaKBYLBePUSrdcKiCcOCRTMnMZ/BIC8k+OZ6URKGLL3aY+NT
         ERrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QE10UDZQ3r5KctDFG038ZVtepXURxKEMA8qw8LlWSEY=;
        b=ZD6NV0l0SYzTpTsC16dBODK7W6HIq0v+c5QFdpxjI+8zzUX/SHFHBnivqTQW+alIAW
         EyVfCK+9OK6rEQsF9dpCnC/QBdliWSpAPsZxuYqHFUm/woapcljieP3cwXENfHRzIcpM
         IXfzojmrcxbgGVamm6FlxX34MV8F2DzO4/D09TjkNLsM539kr2Uy3DNQhJCnce2+uV8D
         H54H0NV5kBvbgFz23RehSTFR2cDzNCMh5zT/UWIkpXOZ+QTjNi54fYODn0Ouu2Ztj0Xk
         ujjWVzc3wAydxopIkwkvlUCeZcMydVoKAZTmuiVdfI15SgvpC8KFc7khvpMG8IFLroCz
         DneA==
X-Gm-Message-State: AOAM533kscGaWDPiZhieARFKRDHuqflnT38EaNc3r61FCOveZS12NsvM
        Ivx+njqkKMIdBDpqbC1SsWA=
X-Google-Smtp-Source: ABdhPJzRo2CpLckZ5BybV2p2mZPEKIPpKjjoDDNVlus8LUvOzoTI2kUV/qOMer0ffg8TPEA8+n5kqQ==
X-Received: by 2002:a1c:df02:: with SMTP id w2mr436740wmg.137.1595492556305;
        Thu, 23 Jul 2020 01:22:36 -0700 (PDT)
Received: from ziggy.stardust ([213.195.122.158])
        by smtp.gmail.com with ESMTPSA id f12sm2805882wrj.48.2020.07.23.01.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2020 01:22:35 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: spi: update bindings for MT8192 SoC
To:     Mark Brown <broonie@kernel.org>, Leilk Liu <leilk.liu@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20200721024819.7150-1-leilk.liu@mediatek.com>
 <20200721094859.GB4845@sirena.org.uk>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <2a1cfaf2-0c58-e0c9-7c70-20a2f84321f9@gmail.com>
Date:   Thu, 23 Jul 2020 10:22:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200721094859.GB4845@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 21/07/2020 11:48, Mark Brown wrote:
> On Tue, Jul 21, 2020 at 10:48:19AM +0800, Leilk Liu wrote:
>> From: "leilk.liu" <leilk.liu@mediatek.com>
>>
>> Add a DT binding documentation for the MT8192 soc.
> 
> I'd expect to see a matching driver patch.
> 

Well for now the device would match against the "mediatek,mt6765-spi" as it is 
the same chip. We just want to define the binding so that we could add a special 
case for mt8192 in the future, if needed.

Regards,
Matthias
