Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD3514A024
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2019 14:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfFRMBo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jun 2019 08:01:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55798 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFRMBo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jun 2019 08:01:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so2943306wmj.5;
        Tue, 18 Jun 2019 05:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oj9R2h7PLbPIbssfUEZGisJttd/OMEPsCeLkAVDP4/k=;
        b=EZbHQj3xMGBqj9Q9GX/wU+YiLHLfXk+cdZg7gRWU9n/Y8XEhWmFdCUR+bTHZJ5cSvc
         KUzll32D21EfZi+MHAOH8vq6rbY/m6fHvYeohptFvTxOqEC386rTUHlyh0nKeIiNS4Wl
         friRRybP9vG4hZB0omRydPP9Df6NCF/z8lJ6CQI0q0ic5hPulqLbxUA9E/iHUvRnx8Jc
         Sw0myf5f4DlMTs4nLW166v7sL6iQKANBux9MRMDV7Sp1REbzRVLEOiXzF5vPZc3paY8z
         VmxE9Pz38snaHNywmkwY+N9aNhb+KCistFLoqqkBjRZoe+xNrX0XRa6FcexZ8mcB2SjF
         tEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oj9R2h7PLbPIbssfUEZGisJttd/OMEPsCeLkAVDP4/k=;
        b=OE+BbU1k7+YIRLQSSeMZE3QJmiSFVsb7MewbmYBEjmcjmQgzGPXcgqazvs8AB1KoQw
         ZzxDFll1pLan/Sc8rCyvEsoFjpI+H2bpNXg64p+4PTblRSyV7WU7I6my1g0D/IH1WKHi
         Ycwa4M51aneIHWJKqUdb+d2yx5fbxC50WFbs/g4eq7WO05ShWkLpAQ8OC9ndIWer3+c6
         d3j9ursqgMmLxdxwqyk09PZ+YrPOZI6lofPgWSJpA6a2OspGsQ9SzcZ1WOqlE3I0UhkC
         tqDcy+4PFZSg8ZrCo99YBKPJXcNPM9e4P2M8qkJCIVeTpAM/fk7zpuxckIAB2XfMwFes
         VBbg==
X-Gm-Message-State: APjAAAUIQpRk2w2WCYlMeElGbbLZfE+wkj7RYgShfHF1fctMYnEZnCIo
        CINaYov5qCQEphfquSchA2s=
X-Google-Smtp-Source: APXvYqzsfBn5Vi+/8ppaMw0HGNWkGiV0h3v4+fwxzpiUXMBe6NlmaVTpFJobraD+wboFQBeWNXiMJQ==
X-Received: by 2002:a1c:3c8a:: with SMTP id j132mr3279580wma.172.1560859301896;
        Tue, 18 Jun 2019 05:01:41 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id r12sm21413531wrt.95.2019.06.18.05.01.40
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 05:01:41 -0700 (PDT)
Subject: Re: [PATCH v13 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF controller bindings
To:     masonccyang@mxic.com.tw, Lee Jones <lee.jones@linaro.org>
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, mark.rutland@arm.com,
        miquel.raynal@bootlin.com, robh+dt@kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
References: <1558423174-10748-1-git-send-email-masonccyang@mxic.com.tw>
 <1558423174-10748-4-git-send-email-masonccyang@mxic.com.tw>
 <0e2994d6-6efc-9f36-f681-609199f20b9f@cogentembedded.com>
 <20190603130428.GX4797@dell>
 <02addf64-9f6e-ccc1-2f94-8983456e3ebc@cogentembedded.com>
 <OFDA7648A0.F1733EA5-ON48258411.002946DF-48258411.002A2F0D@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <2671d488-82a1-8720-d9a1-03554d955a38@gmail.com>
Date:   Tue, 18 Jun 2019 14:01:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <OFDA7648A0.F1733EA5-ON48258411.002946DF-48258411.002A2F0D@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 6/6/19 9:40 AM, masonccyang@mxic.com.tw wrote:
[...]

> RPC-IF works either in SPI or HyperFlash is decided by external hardware 
> pins 
> configuration and it can NOT switch it's operation mode in the run time. 
> This is not like my understanding of MFD.

Which external hardware pins decide the RPC configuration ?

It seems to me like PHYCNT register, PHYMEM bitfield, selects what
device is connected, and then a couple of other bits control the
communication, but I see nothing which would be tied to any external
configuration pins.

[...]

-- 
Best regards,
Marek Vasut
