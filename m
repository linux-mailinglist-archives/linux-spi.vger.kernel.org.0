Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2830712A349
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2019 17:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfLXQ6Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Dec 2019 11:58:25 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45698 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfLXQ6Z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Dec 2019 11:58:25 -0500
Received: by mail-lf1-f67.google.com with SMTP id 203so15420942lfa.12
        for <linux-spi@vger.kernel.org>; Tue, 24 Dec 2019 08:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J9xVipWdZ9ewXXkBZXIrSrABSMZzc9X1MMnhoAbWXlE=;
        b=W0hlLL5DhTEpCFv0TCctzYOTXyobKMI6Y6UJK8+lDzVhnHItHqQwaIpn680DfYumSV
         L8WcWNVtAVhspp+9zGEG05NY2Th2BRK8yr/LBjNXiqAM/JFXdq2isbMLHBZPrMvXg/n0
         pF/574ew1QU8lMu8AA68vrFTMlZwzN43O4YFR0soGdns80TeDSeZlF/mUZ1fMejn/WEj
         BkgoETEWv70bXzccrBSJ1DQ4IYDU3/uJLE1qGrL0sJyHHXvZSlpG7TKjSdqmBnzcNne/
         mhRNJ6DrtfIb3G8kzyuQlh3QToM5aJZTIlslg0SRb1VYd9JUY0o5Ayl8xO3zpTXgisBm
         PoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=J9xVipWdZ9ewXXkBZXIrSrABSMZzc9X1MMnhoAbWXlE=;
        b=f3eP7oXSk6H30s0wmpyo2ReMtcGLVF6nQzgGnf0Lo96dLUnRhgSq+K+wG2WEt6eIPx
         4UkCS4LEmX02o4zsvKkYN1cMqsJyf4ui9ygqhpZnHz2ti/NS3GhTxNEFrkkH4hTYhhXL
         TuST5E/clXjVMDaknevdsk1AVaqD7LHsmuTjyH64OeOhxIaoBwMFSx63ZUkmJnorNfRv
         oMBZwoPUgqU13v7yp21MburZ5CCd2dhuI6ZrUT+7e/UPyjtyc6VVNMuwC5p52P9yZoA6
         p1M7x3dGObADcEHZlLu+kAc/vNhPJgqjDSZ2I15xs3Jr0pqswqSFxi73CI4ExMGYT8A1
         tc1Q==
X-Gm-Message-State: APjAAAWLCpXXesMpxBtB+L4b78EoSHa7rANoYbh6VAUAduppS+PSWCz5
        eFmLHlwJbI8hVCrnw6/olZYnWA==
X-Google-Smtp-Source: APXvYqwV8IVoVjnuRZBeIW/7BCYcFzMxWYQyUyZDt6oXFV1ZN/xkagQ1KHils7pYZlCWzv9yW2hdjA==
X-Received: by 2002:a19:c1c1:: with SMTP id r184mr20571865lff.128.1577206703390;
        Tue, 24 Dec 2019 08:58:23 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:441d:5f5:f336:feb9:305c:b1aa])
        by smtp.gmail.com with ESMTPSA id x21sm10232507ljd.2.2019.12.24.08.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Dec 2019 08:58:22 -0800 (PST)
Subject: Re: [PATCH v2 0/6] spi: Add Renesas SPIBSC controller
To:     masonccyang@mxic.com.tw
Cc:     Mark Brown <broonie@kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <922cfa46-efb5-9e6d-67ea-3ac505b8211c@cogentembedded.com>
 <TY1PR01MB156215E8668C0317FA0826B18A580@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <e6a73df5-31c4-3472-f7bc-a0984f1f5380@cogentembedded.com>
 <TY1PR01MB1562D343E1AB06DCA2973DAC8A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <590840ce-a250-2512-3d04-c2420d83f7da@cogentembedded.com>
 <TY1PR01MB1562B9EB96818DCA507079808A510@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <bb630141-021c-5618-f266-b98b29956fa8@cogentembedded.com>
 <TY1PR01MB1562E196AB1C582F186CC74B8A520@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <6f4c5d92-3ca4-2d1d-47c4-cbd52ad428b0@cogentembedded.com>
 <OF3F92D76C.33FFFBFC-ON482584D6.00093DAC-482584D6.0009A51D@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <bac1f4db-302d-0dd7-3b66-341a74f67a6b@cogentembedded.com>
Date:   Tue, 24 Dec 2019 19:58:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <OF3F92D76C.33FFFBFC-ON482584D6.00093DAC-482584D6.0009A51D@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello!

On 12/20/2019 04:45 AM, masonccyang@mxic.com.tw wrote:

>>>>> So at the moment, there is nothing yet for me to 'try' on the RZ/A series,
>>>> correct?
>>>>
>>>>    Why, I can send you a working version of the SPI driver, and even HF one
>>>> if you're
>>>> interested.
>>>
>>> The point of this whole discussion is to determine if we should have 2 drivers
>>> for the same Renesas HW IP.
>>>
>>> There was a RPC-IF patch series that made it to v17....and is now dead.
> 
> It's under review by Geert Uytterhoeven
> 
> https://patchwork.kernel.org/project/linux-renesas-soc/list/?submitter=181859 
> https://patchwork.kernel.org/patch/11078131/ 
> https://patchwork.kernel.org/patch/11078133/

https://patchwork.kernel.org/patch/11078137/
https://patchwork.kernel.org/patch/11078139/ 

   It doesn't matter much what's in the renesas-soc patchwork, the patch would
be merged thru the linux-spi repo, and in their patchwork the status of your v17
patches is "New, archived"...

> thanks & best regards,
> Mason

MBR, Sergei
