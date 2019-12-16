Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFC781218F1
	for <lists+linux-spi@lfdr.de>; Mon, 16 Dec 2019 19:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfLPSrd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Dec 2019 13:47:33 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41370 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbfLPSrb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Dec 2019 13:47:31 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so7934215ljc.8
        for <linux-spi@vger.kernel.org>; Mon, 16 Dec 2019 10:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZzVqpm7vISxN2XVUCXGY2m/2XgAiTT0hZi9cW/dInYQ=;
        b=dZKk5AqvtPHFii8jZi+8J/lePw5/aQn7GaI4xJEsfiKeEXKxrjqY7SsMgUzuGBuAnJ
         lhHmUXQNOUmAKADBgGGctmtIDE3s/1+6pcASqF2hFgTu8mD30bn9yMBCo9ZTLNOxljHx
         QYDm+2L84AhvHNfnxjn+ViFTqrOeIfMOVPu7Prn88zScJX9hR2BR2hWtwKdwQrdLAV2Q
         eMvufEfsfkYQJhyt6Ah6X7ItvTdP8KnIZaJQ0bHcOQ1ywCsoMJ4rdxsO8mFO1zOkOPES
         nuI7/rn3Hlv7CyP/TU81LEOUpC8Pqo6udw7BvliaHjOa/FSQLmOs+87UyF19Vsk+bk65
         Mi/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZzVqpm7vISxN2XVUCXGY2m/2XgAiTT0hZi9cW/dInYQ=;
        b=NDjyKX1TCet6iBAg1cij9Lgep+JyyqLl6hV2N7hx9C6rIOdLfjkYPlqawz6meGHj6i
         yJzqy7TsVJhX1NOzeG33IdWbT4V6OVIJPfB8qWscQgQVLGFkQUGTLrdqtoALD20nTuWj
         tiSjLMcMSPXxjtVEvv+Go0OoPdsviIwck7anr01mwRj3kpmpm24xUMQkzKDJoeIPdFTK
         2OwxhqTU0iU5hpMLgZJf8QLqw06yYbm2RrGsgGlA4YmnI858bKwN6kMOkVMX0TiZDq33
         +BQ4wmW3lARQoqxSPVp/j68V4zSKMsIdf+Qmu/j3QGOh9zuN0lt1CCR7pScaHVoa+Tux
         cdHg==
X-Gm-Message-State: APjAAAWVrNRZY0U0E2HH3JzKPAGb2Q4MTMCCrV5TSriBPN20vhfEy/RM
        QX20bXfwlggd795lDfapI1k/LQ==
X-Google-Smtp-Source: APXvYqwA7Ysm4UNtu9E+akNwfRxfaN3bIefRHQCWigpiGZVf0Q7o0UssOPcmwHdK6c+oVuOA9w9V3Q==
X-Received: by 2002:a2e:3a12:: with SMTP id h18mr379963lja.81.1576522049068;
        Mon, 16 Dec 2019 10:47:29 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:48df:e424:ff05:dd96:8970:d4c9])
        by smtp.gmail.com with ESMTPSA id g27sm9427223lfj.49.2019.12.16.10.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 10:47:28 -0800 (PST)
Subject: Re: [PATCH v2 1/6] spi: Add SPIBSC driver
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
 <20191206134202.18784-2-chris.brandt@renesas.com>
 <37c13497-d20f-583f-72d7-1e3c8a241990@cogentembedded.com>
 <TYXPR01MB1568ED4D40CEC399E64F6A2B8A550@TYXPR01MB1568.jpnprd01.prod.outlook.com>
 <7386b38f-2f52-39cb-3887-e97b024ec563@cogentembedded.com>
 <2e3211c6-59e8-3057-66a2-29b89a353b8a@cogentembedded.com>
 <TY1PR01MB1562F30F0B58465A6988F29C8A540@TY1PR01MB1562.jpnprd01.prod.outlook.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <a9b051ac-da70-37bb-bb82-540f0f161b25@cogentembedded.com>
Date:   Mon, 16 Dec 2019 21:47:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <TY1PR01MB1562F30F0B58465A6988F29C8A540@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12/13/2019 11:43 PM, Chris Brandt wrote:

>>    The patch isn't applicable as well, and the behaviour is the same as in
>> 5.2.-rc6 based
>> kernel --deleted file is back after remounting, sync or not...
> 
> Do the basic R/W operations works?
> 
> Here is the first test I do on my platforms. After I passed this, everything
> else seems to worked pretty good (writing large files).
> 
> $ flash_eraseall -j /dev/mtd4
> $ mount -t jffs2 /dev/mtdblock4 /mnt
> $ echo "hello" > /mnt/hello.txt
> $ sync

   This works but the created file doesn't survive a remount.
 
> If the Flash was recognized at boot, then we know that the ID command (0x9F)
> at least worked. Meaning read commands were at least working (which is the
> difficult one for this HW...writing is easier)

   BTW, during boot I'm seeing with thsi driver:

spi spi0.0: setup: ignoring unsupported mode bits 800                           
spi-nor spi0.0: Failed to parse optional parameter table: ff81                  

   (The 2nd message is also seen with my drivers).

> Chris

MBR, Sergei
