Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4AB126C1A
	for <lists+linux-spi@lfdr.de>; Thu, 19 Dec 2019 20:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfLSTBW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Dec 2019 14:01:22 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42702 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbfLSTBU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Dec 2019 14:01:20 -0500
Received: by mail-lf1-f65.google.com with SMTP id y19so5092954lfl.9
        for <linux-spi@vger.kernel.org>; Thu, 19 Dec 2019 11:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EnctfXeH6eSWsiC3SsB5Huqb0Ku44kDLoFN9p69SIAE=;
        b=lEbPRqMg9JeGspNDXadsO0erORgltj+FUrBlrmYlwUjMc774JfhJ6eRumOi/hEBQc1
         j/UkZlmTqlmFwyEQAz0i+0DGHuUvbLlC4AKLAlUIVPRGHmaqEzY7+6gI88wUx8LOezTp
         6BQkhhD7gDpCJs7CNaKeplHsSflIs3AJgQMoNNyxeUH2ebKSk56q+NCyIZzeeWfZcHFv
         HXQi+nxzjx1jRs9VMt4b6suCTgj9NDXnNpu11YNAKN1Kb+CZB9H1JhhcELAP7azOQw7P
         1t4g9xWB8JNohzB+7BNQ21UOE2bci6K1O+MtXz5/dnZo8E0LfZv8LjVO9BimFwtNU4aD
         h2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=EnctfXeH6eSWsiC3SsB5Huqb0Ku44kDLoFN9p69SIAE=;
        b=fdCQ7zRm12qQzpOC8bc495MpftvgotsHuLxfEOn7dkFYDULO+lEEm3fncxlOLtS8Q8
         2dSwQHFbyvMAQUYlLlTEI6RvXsncnAxUBBmyeGLKNydMm2paWBKbbZeh8+2b/7iuMZlD
         DerP6awAASmDAYfBO7lwNfUGRm9Mon+VRDq5ULa8J3xGl0TT8hfCHgEZ4CnBxPuBkW3h
         p67qgWVik5YPIviLVGRL3RdYr3xsUTBKbqCsGUaH4YuB3ZgXvkQJpD92n0l3cFtw+noH
         Ms9Fk+jJ+9QDPn6S+Wx0bJSBI03ZnCndLmMRVHTP3ll62Bl7247tMsJJmpdszr5p2A6q
         IkdA==
X-Gm-Message-State: APjAAAV3TMqbZjMIN4ABVttqVDdX3tpypVDLiui4Lai7+XGrXmun/xap
        kWL+TzszuGkduc+gjMBp8vN4GQ==
X-Google-Smtp-Source: APXvYqznQi99px26YNP9vyR+IDtMFUiA2KIXWA7/G1NfQxBqe4E+4935xoJv7nCF7+iJcnj4xRyJ5A==
X-Received: by 2002:ac2:50cc:: with SMTP id h12mr6326667lfm.29.1576782077671;
        Thu, 19 Dec 2019 11:01:17 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:899:8379:9861:263:6bbe:73b8])
        by smtp.gmail.com with ESMTPSA id z5sm45547lji.40.2019.12.19.11.01.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 11:01:16 -0800 (PST)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 0/6] spi: Add Renesas SPIBSC controller
To:     Chris Brandt <Chris.Brandt@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <922cfa46-efb5-9e6d-67ea-3ac505b8211c@cogentembedded.com>
 <TY1PR01MB156215E8668C0317FA0826B18A580@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <e6a73df5-31c4-3472-f7bc-a0984f1f5380@cogentembedded.com>
 <TY1PR01MB1562D343E1AB06DCA2973DAC8A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <590840ce-a250-2512-3d04-c2420d83f7da@cogentembedded.com>
 <TY1PR01MB1562B9EB96818DCA507079808A510@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <bb630141-021c-5618-f266-b98b29956fa8@cogentembedded.com>
 <TY1PR01MB1562E196AB1C582F186CC74B8A520@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Organization: Cogent Embedded
Message-ID: <6f4c5d92-3ca4-2d1d-47c4-cbd52ad428b0@cogentembedded.com>
Date:   Thu, 19 Dec 2019 22:01:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <TY1PR01MB1562E196AB1C582F186CC74B8A520@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello!

On 12/19/2019 07:57 PM, Chris Brandt wrote:

>>> So at the moment, there is nothing yet for me to 'try' on the RZ/A series,
>> correct?
>>
>>    Why, I can send you a working version of the SPI driver, and even HF one
>> if you're
>> interested.
> 
> The point of this whole discussion is to determine if we should have 2 drivers
> for the same Renesas HW IP.
> 
> There was a RPC-IF patch series that made it to v17....and is now dead.
> 
> You sent a new RFC series for a new method, but all it had was low level APIs,
> no MTD framework, do it didn't really do anything.

   Apparently you have missed the previous RFC iteration, the MFD/SPI drivers posted
at end of May:

https://patchwork.kernel.org/patch/10969211/
https://patchwork.kernel.org/patch/10969213/
https://patchwork.kernel.org/patch/10969217/

   There's not yet merged MTD patch you'd need too:

http://patchwork.ozlabs.org/patch/1199645/

   The MFD driver was shot down by Lee Jones who has advised placing the common
code into drivers/memory/ instead... I don't want to re-post the SPI driver as
I haven't yet addressed all of Mark Brown's comments...

> If there was a complete patch set that I could try on the RZ/A SoCs and 
> get a working SPI MTD device to show up, then I would drop my efforts of
> getting my driver in and just add RZ/A support to the R-Car driver.

   Please try these patches, there's a big chance they'll work. 

[...]
> Honestly, I'll be out of the office until January, so it's not like I'm 
> going to do anything with it until then. But if there is a complete series
> to try by then, I will see how it performs on RZ/A boards.

   Hopefully I will have addressed Mark's feedback by then and post the new SPI
driver... Have happy holidays! (Ours happen on 1/1 and last till 1/8 this year.)

> Chris

MBR, Sergei
