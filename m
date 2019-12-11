Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6705911B876
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2019 17:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbfLKQU4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Dec 2019 11:20:56 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35022 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730062AbfLKQU4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Dec 2019 11:20:56 -0500
Received: by mail-lj1-f194.google.com with SMTP id j6so24762505lja.2
        for <linux-spi@vger.kernel.org>; Wed, 11 Dec 2019 08:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tD2y5jZ8oTLJe6LbTN27zTEPS2JKCut3FdE1zrzBkUs=;
        b=XHByjpVpksAhQp6qWGC8ANRLf3D8pRxjhxA0kZBgeoQGbehbI4T4UsJjHdjOSy3qGm
         lUR2sJZ7SZ8KAasxNhMFG8wLboHF8Zhuv/dN4u9DCZ5V4ZcQbl9wog+i3wbxinYLhBn9
         MWXrZ28CAqcehkq7JynVp3OljN9N9gEfCTpst2pHJdC3HM3jJEPO1gskys5+aLtTz/0D
         sZ9MGH3g1KvShyB5NXhEXXirzTrpo14gy5QN41m5YeZTKRpCjKTtkOrWf0IA3LPwDp1W
         +PsL2xzzi6yBkHO+ybkGzuDYvoNZ/nsonXCW4Er4mOvDb5LTfMggKU4Onf4p87/ZLLUS
         iNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tD2y5jZ8oTLJe6LbTN27zTEPS2JKCut3FdE1zrzBkUs=;
        b=oULjh5jxbLGugS3hbqP4Vhw8qIHds5lCv/vPETvFssWLVpqP6lGEIEbbDe6ScQBrub
         5xnXU8nBYqail23IMNBv5Qju6lkcJL4k1llHTCK9JudXMO3M3rPykwoxuNFg6BieQ8bc
         xTVJh5OlcLyPcEPzuB1a/TrBwoOK7lkSt++eZGW4p5GszQH3ptFX1P9oUJGgZ2cPkaud
         n8POHFyFiBtsyEcxmKg3ncDuxkgBn+cA0/LOnAsyMOZLyKZB/GWOV/L48Z8VDcqPZNz4
         KaSEkPon943NcnzLUhxtjEE/KJidVYfLL84Z7RlJF/X/6BtYFKh80tP1f3Xi/YF/z2mJ
         P55w==
X-Gm-Message-State: APjAAAWDrDlUVXyaKFJbG7XU3l0ycurb+VVx2zRb5Hy8VxgiBd3WUYD1
        7SPBF6NtKWGJw0peLi/t9vr9Tf9xbgAw8Q==
X-Google-Smtp-Source: APXvYqx7JrnjYVzZSKhxIhgqUUFwGRNOWBlKZgUUrH2giZBqcw9jTeOd1HzQIZ2qu+jUtLHmUW373g==
X-Received: by 2002:a2e:b017:: with SMTP id y23mr2776840ljk.229.1576081254052;
        Wed, 11 Dec 2019 08:20:54 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:8d8:12fe:a87e:d4b8:621e:2b62])
        by smtp.gmail.com with ESMTPSA id n19sm1434257lfl.85.2019.12.11.08.20.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Dec 2019 08:20:53 -0800 (PST)
Subject: Re: [PATCH RFC 0/2] Add Renesas RPC-IF support
To:     Chris Brandt <Chris.Brandt@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Yang <masonccyang@mxic.com.tw>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
References: <cb7022c9-0059-4eb2-7910-aab42124fa1c@cogentembedded.com>
 <TY1PR01MB156234F5B44BB43D3DCA98128A5A0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <0af05149-78f5-8639-4a23-84edda0073ea@cogentembedded.com>
Date:   Wed, 11 Dec 2019 19:20:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <TY1PR01MB156234F5B44BB43D3DCA98128A5A0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12/11/2019 05:33 PM, Chris Brandt wrote:

>> Here's a set of 2 patches against Linus' repo. Renesas Reduced Pin Count
>> Interface (RPC-IF) allows a SPI flash or HyperFlash connected to the SoC to
>> be accessed via the external address space read mode or the manual mode.
> 
> Looking at this driver, all it is are APIs. Meaning another driver is 
> needed to sit in between the MTD layer and this HW driver layer.
> 
> In the driver that I did, if the "RPC" HW is going to be used to control
> a SPI Flash device, it registered a spi controller and then the MTD 
> layer could access the device

   Via the SPI-to-MTD sublayer for (at least) direct mapping -- grep for "dirmap"
in drivers/mtd/spi-nor/spi-nor.c...

> just like any other SPI controller driver. No
> additional drivers are needed.

   Then why do we have *struct* spi_controller_mem_ops? Do All drivers implement
such ops?

[...]

MBR, Sergei
