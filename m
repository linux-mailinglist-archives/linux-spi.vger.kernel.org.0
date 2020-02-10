Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41AE71582E8
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2020 19:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgBJSnz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 Feb 2020 13:43:55 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34487 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbgBJSny (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 Feb 2020 13:43:54 -0500
Received: by mail-lj1-f193.google.com with SMTP id x7so8508107ljc.1
        for <linux-spi@vger.kernel.org>; Mon, 10 Feb 2020 10:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QEgGz7bQb3IXiAQFonh1aT+riZEVShoAuJBFxeYMGjg=;
        b=jI496UDLPxXjEgeroTwoGYVSO0vYBjg41BU0Nsop5Bku/NtgxtlIVKK3torrHAaa69
         12bidnBLsSqh0gvrkpbakOH8y8IchOhedqDrwcK+DANswT04AJATdbUZhTOjgbMSddpu
         HzeTQY8NQxh+9QTlsj+RooU3rKyqoqcMUa6fsCwxdewwOiC7e38hlGM4qUMpw/G2Rfua
         6ZdWwW5Rb75efPnXTCECnFpInUUOJMCgN3WzudHIV1B3jPOM+/BnpNQVFxDDNxN/M+gb
         azZefbvXcDlVx/2pxRPWh7SynfzIW0djL7GSzdovb1uiS4vkH/CMRLgpXGlEkm+d1e7Y
         TwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QEgGz7bQb3IXiAQFonh1aT+riZEVShoAuJBFxeYMGjg=;
        b=E6DICg0q8B76do/Z29Nb5NFdwGjhnGuEe1EIj7XjUJEkBcUGiAk+/nvotPAEejy7JK
         G/bVhp/eFRbrawX7ypO3d13J0NS4eNRSEkEItvpNJ4bCmilPqWRQa0/+D7Bra11M/E2F
         o7HTdlnxb1mkyxWe+N/fvQ9ndQvD4COXjT39tpqZEcxk45ojqFcp2wwXSXIJ/04a+SZc
         j290bO9ktXJJZBgP2VOaPnhr9htXUcfa6fERd2OKEb5WJlMCmd6aQw5sfnlsBLzM6RLU
         ietiBiTdRsZzIYgX2u8X/cwM7oYwwBQmFjWeQ55H8RG75YM/n7FLa+rzHwca93oSWnCc
         NNkg==
X-Gm-Message-State: APjAAAVF7pymWEZXO9t4uRwN1QKrjpvkPnhqWzfPBAO2/b70tWOlCPNe
        Ul1uU3jOr901SsaD+2FH7FAkVxXbmwQ=
X-Google-Smtp-Source: APXvYqzv5QYn2Q2b4p5hnJ+krl4hvXWMkghwKCLawwTFawBqlUeysMfTenMjTwm6ymLdPcyjpUY1Hg==
X-Received: by 2002:a2e:7005:: with SMTP id l5mr1642914ljc.230.1581360231338;
        Mon, 10 Feb 2020 10:43:51 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:4880:e22:9ddc:6793:8eb0:990a])
        by smtp.gmail.com with ESMTPSA id n206sm547986lfd.50.2020.02.10.10.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Feb 2020 10:43:50 -0800 (PST)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] spi: add Renesas RPC-IF driver
To:     Chris Brandt <Chris.Brandt@renesas.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Mason Yang <masonccyang@mxic.com.tw>
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
 <6515c5ec-8432-0b20-426d-0428bbdf3712@cogentembedded.com>
 <TY1PR01MB1562509AEBD0B4460D3FEC798A1C0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Organization: Cogent Embedded
Message-ID: <30c1fc59-cae6-8993-bbb1-13a5385123ee@cogentembedded.com>
Date:   Mon, 10 Feb 2020 21:43:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <TY1PR01MB1562509AEBD0B4460D3FEC798A1C0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello!

On 02/08/2020 01:36 AM, Chris Brandt wrote:

>> Add the SPI driver for the Renesas RPC-IF.  It's the "front end" driver
>> using the "back end" APIs in the main driver to talk to the real hardware.
>> We only implement the 'spi-mem' interface -- there's no need to implemebt
>> the usual SPI driver methods...
> 
> I tried these patches on an RZ/A1H RSK board.
> 
> At first, things were looking good. It would probe the SPI flash correctly
> and I could read out data.
> 
> But, when I went to try and do an erase, it all went bad.
> Looking at the actual SPI lines, the commands coming out don't look like what
> I would expect from an MTD device.
> 
> For example, I do a 
>   $ flash_eraseall /dev/mtd3
> and all that comes out are Read Status commands (0x05).
> All the write enables and erase commands are missing.

   Well, I have warned that writes don't work.

> So, it looks like any command that is a write-only never actually sends
> anything.
> 
> I did try and do a page program command:
>   $ echo hello >  /dev/mtd3
> It sent the page program command (0x12), but in this case, it still didn't work
> because a write enable command was not sent first.
> I assume the MTD layer is requesting the correct sequence of commands, but
> Somehow this new driver is dropping of them.

   Would explain what I saw (writes not surviving a JFFS2 remount)...

> Chris

MBR, Sergei
