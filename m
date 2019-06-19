Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEA44C144
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2019 21:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfFSTLJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Jun 2019 15:11:09 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46664 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbfFSTLI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Jun 2019 15:11:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so244671ljg.13
        for <linux-spi@vger.kernel.org>; Wed, 19 Jun 2019 12:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DGOglYyfX7mGgGEgVmzQPpmnWJKM5QaRpbisBQnw/Hs=;
        b=Ix3D32NGWT6WeehaQRn+2JAI1ozE3isAEHzdkGJlfOCar24PdPro1hsvhx+CfNoaau
         qN5NTgPdP9XFjqNb2lJ4BLNU37oJ8tBtS4+vIiklAs00YBXMbmNa/n/mlBxLwidy60CJ
         g/RwttFXJFvXhilta86zLjC/1j0acLT/LHKik/QvbsD5XxSVgTK6hXLWhdaPdDnrIgnd
         yuevKQTp+hA+Z2QsfHeQN47X+QLffQ8Fpxix6VOFq1CzAhAPoBHv8G5iUJ8znvhVSJxr
         /WJ8vz0uFztPhWTGPwhmaJ5VK9W8W22MEwPcUWd6+WPHAJdJ7dm/SFNPgPqJ6rquasAW
         UqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DGOglYyfX7mGgGEgVmzQPpmnWJKM5QaRpbisBQnw/Hs=;
        b=i/SunhvvskMc1pTHRmsqCE1XMUGT7Hy//mTV64GJ4ahjdlrZU/gG1k7Ilx4ebE4T1y
         /ddoEDMprP4K7fWvCmAYvUndXPHqLFJPJgzKsGD6UB/yjgCt/2cIkcrzL8JOk2iYYJCO
         cTqkWHBus580Uks0yWgU/bdFEUvPdeafZF+eA8rreB2rfUVe6tiSRSjPEjPPTOK9uB0+
         593mlTzkf7B3OTHcnhmUOl66vZ/7yA39sV4W0sbHtCneUfVaTKZ5sdMaCSqPamSRzcrK
         FIrJTkKlT3l8LLjSqaTcKQG2QNERTJP8Y/Q4bTlVxYjUXTrAqwpaQqV+SHATAY/u+EOm
         DEFw==
X-Gm-Message-State: APjAAAWSe8/Ffq9zBWfazB34wDPHt/6IShj23AQ/yRk0DZf6xrVZLXgt
        1ziJ6W9TW1PaWwJ4CKXMr9EBYg==
X-Google-Smtp-Source: APXvYqxovE7fTRUIYjNby4iWFlTkjV4sbynKSqYpv5pcUb6vzNb3Lc3/9S5irofX6DIiYzLICQX+Fg==
X-Received: by 2002:a2e:9e8e:: with SMTP id f14mr43867664ljk.120.1560971466591;
        Wed, 19 Jun 2019 12:11:06 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.80.22])
        by smtp.gmail.com with ESMTPSA id o9sm2788084lfb.47.2019.06.19.12.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 12:11:06 -0700 (PDT)
Subject: Re: [PATCH RFC 2/2] mfd: add Renesas RPC-IF driver
To:     Lee Jones <lee.jones@linaro.org>, masonccyang@mxic.com.tw
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi <linux-spi@vger.kernel.org>, juliensu@mxic.com.tw
References: <20190612090552.GD4797@dell>
 <41d74ecf-c939-27e1-4ef2-ad052b4e924b@cogentembedded.com>
 <20190617093048.GD16364@dell>
 <CAMuHMdX6GC2ZDam=odC-QFLUdrh1PYPVWEo5x3EHduqJ4FmTng@mail.gmail.com>
 <20190618091955.GN16364@dell>
 <CAMuHMdX7fFSO25TPJA9PO=VQC0czKux8nritMeffBcnaxr=WMQ@mail.gmail.com>
 <20190618095741.GA18371@dell>
 <ff85a907-8f26-5e80-c7f0-655ca11afe25@cogentembedded.com>
 <20190619061659.GH18371@dell>
 <OFB918AE65.CB02BB75-ON4825841E.0025C688-4825841E.00265891@mxic.com.tw>
 <20190619075422.GJ18371@dell>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <c8dab2f7-3ddb-497a-bb14-dded31930ce6@cogentembedded.com>
Date:   Wed, 19 Jun 2019 22:11:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190619075422.GJ18371@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 06/19/2019 10:54 AM, Lee Jones wrote:

>>>>> Looks like a flash device to me.
>>>>
>>>>    More like a multi-protocol flash controller, with the real flash 
>>>> chip connected to it.
>>>
>>> Right, this has been my point from the start.
>>>
>>> It's a flash controller.  Sure, you can access it in different ways,

   No, the software access will be the same, just the initial controler
setup will be somewhat different depending on the flash type used...

>>> but it's still *just* a flash controller and thus not a true MFD.

   Also a SPI controller when a SPI bus is used.

>>> Surely this whole thing, including the shared portion should live in
>>> one of the memory related subsystems?
>>>
>>> This is not the first device people have tried to shove in MFD, that
>>> is really *just* an <X> device, able to be controlled via different
>>> protocols.

   You somehow still mix the (master) controller and (slave) device,
it seems...

>>> MFD is for registering child devices of chips which offer genuine
>>> cross-subsystem functionality.  It is not designed for mode selecting,
>>> or as a place to shove shared code just because a better location
>>> doesn't appear to exist.

   OK, fair enough...

>>> Also, ramming it into drivers/platform/<vendor> is not correct either,
>>> since this is not a platform controller driver either.

>> I will patch RPC-IF back to SPI only and 
>> rebase onto previous patches as bellow:
> 
> This sounds more like the easy way out, rather than the right thing to
> do.  Just because this isn't an MFD, doesn't mean it's not suitable
> for inclusion into the kernel.  Take a look at drivers/memory/Kconfig,
> and see if any of those devices sound familiar.

   TI AEMIF sounded familiar, I have some DaVinci/DA8xx background.
Trying to wrap my head into (missing?) API in drivers/memory/...

MBR, Sergei
