Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7CDC11EB2C
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2019 20:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfLMTkx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Dec 2019 14:40:53 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36215 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbfLMTkw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Dec 2019 14:40:52 -0500
Received: by mail-lf1-f65.google.com with SMTP id n12so140867lfe.3
        for <linux-spi@vger.kernel.org>; Fri, 13 Dec 2019 11:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bVhxuw3U393oiAUQj7fA3kxc/h8CwqH5wT8JhWvqjHQ=;
        b=T4WL5w2Q4w+qRSNL/hkYIWyvtAW/g2uEyd9p1CgPYWERbVisrPxJOayh/341jwAZWU
         P66qKGo1QvOT6IY42+Mv3EH1hQk93I/Jy/6Rq6Tk8k9RrYVhxBK7iJC0JPxd28hS0l1X
         PpkhEQrVyazq5s27vs4GQwUjSano21nBb45IsZoONL4DCE7I+ZHpyAh5BJvkZlJNTv94
         6w23M/w1R3HwkFEUV6xkrTciA5rl1pAG8kh2ozL96EYwRm6YN99YmJB10TD71m4H+MaV
         S4lugsgTVwQxf9HxxMinXarwjurfIwEqa7+xY3F6wFtZ/8YbhYOWA/xS7+G/yXZ/b0Ry
         ZFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bVhxuw3U393oiAUQj7fA3kxc/h8CwqH5wT8JhWvqjHQ=;
        b=Es3I6g7a7VD61Wd4kaYiChybJqUTXbIKBnxS6EJ9yjk/sNxdVoKPSe7MD5JAkUyXwy
         +u0gZLrrYY24KBXCYuFqEvuI+Bux1NwFPsStHaNnt2qgmPKKHsEfzEOl1Kpdus/WWJ68
         pLGnHKsa1IIbNbbpcQjSBJhbXLl6IRHdJLry9AF7rfj47CXchWf2BRFs01Tnl36aCg0L
         Tf7LeB/KxzgPhwOeF9E7IAnfZD1T71gCLaZPxbB9w9BUXFF/CoZluyd7TwbIG5cp/2vn
         T4LQ/UTtpKKB06a0lYO4cyBbzdaIoOgPPWXFuEnNvgALUQ2yLV2NdAJu3SI1B9xMXOyO
         vvew==
X-Gm-Message-State: APjAAAUvCHwZSHX/6NM176bVDJC6sqeti/zFaiJgNexA0BJQF2vh9F6n
        Ax1yHaXzNxJhrIdEsFzR7NO8iA==
X-Google-Smtp-Source: APXvYqy+11kJDOUWH7a9xyQORofMguHFd8W7+BTOYNmjzqWMhTye5Cm2Cb410FjmI2JiNvyxEVZE5Q==
X-Received: by 2002:a19:8c4d:: with SMTP id i13mr9891168lfj.42.1576266050468;
        Fri, 13 Dec 2019 11:40:50 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:42e:41d4:b11e:4c1d:868f:dabe])
        by smtp.gmail.com with ESMTPSA id q186sm5491277ljq.30.2019.12.13.11.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 11:40:49 -0800 (PST)
Subject: Re: [PATCH v2 1/6] spi: Add SPIBSC driver
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
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
Organization: Cogent Embedded
Message-ID: <2e3211c6-59e8-3057-66a2-29b89a353b8a@cogentembedded.com>
Date:   Fri, 13 Dec 2019 22:40:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <7386b38f-2f52-39cb-3887-e97b024ec563@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12/13/2019 09:36 PM, Sergei Shtylyov wrote:

>>>    As you can see, the deleted file is back after unmount/re-mount...
>>
>> Did you do a 'sync' before you unmounted?
> 
>    Now I have -- no change.
> 
>> With the RZ/A2M EVB:
>>
>> Welcome to Buildroot
>> buildroot login: root
>> $ mount /dev/mtdblock3 -t jffs2 /mnt
>> $ ls -l /mnt
>> total 688
>> -rwsr-xr-x    1 root     root        703448 Oct 31 09:08 busybox
>> -rw-r--r--    1 root     root             6 Oct 31 09:07 hello.txt
>> $ rm hello.txt
>> $ sync
>> $ umount /mnt
>> $
>> $
>> $ mount /dev/mtdblock3 -t jffs2 /mnt
>> $ ls -l /mnt
>> total 687
>> -rwsr-xr-x    1 root     root        703448 Oct 31 09:08 busybox
>>
>>
>> Note that I also needed this patch in my tree.
>> https://patchwork.ozlabs.org/patch/1202314/
> 
>    I should have mentioned that I was testing in Simon's renesas.git (thus 5.2-rc6),
> this patch is not applicably there. I'll now try Geert's renesas-devel.git (5.5-rc1)...

   The patch isn't applicable as well, and the behaviour is the same as in 5.2.-rc6 based
kernel --deleted file is back after remounting, sync or not...

>> Chris

MBR, Sergei
