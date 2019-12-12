Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32D5911D731
	for <lists+linux-spi@lfdr.de>; Thu, 12 Dec 2019 20:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbfLLTgn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Dec 2019 14:36:43 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36333 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730761AbfLLTgl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 12 Dec 2019 14:36:41 -0500
Received: by mail-lf1-f65.google.com with SMTP id n12so151968lfe.3
        for <linux-spi@vger.kernel.org>; Thu, 12 Dec 2019 11:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lIK7T8B7Eyyku8RF0XNgNwtCGhRp7hkIh7+TFMDTOOM=;
        b=lGc6HuLSAiMqXLMDP/tAyif2jwHyEA6NsPow0XZ3qXGTakl08BokK7tnFnkRXIYVT4
         CB+WqxsNtTwVLVA1yChKPip/IMbsON8pgRvKA5uMK+GL+s/ReQwFrXSJS/aIcDc25jPO
         NQcVSSANR21HgM77FanVSlyChehzNv5KcWsgAWxYP5IhhkHTQeF9lT++50iw3iNU38Xg
         RRKHqENHjODrPdGnUvQaeOiDEDZTZIwjPe4DKFeUY6nYFetlY/d5Jhv8aGTFSl+Koqdl
         rWlDmGR8MgXaYe9WGKZz1ZmW3CfvmOOyGOrSXr7JcvlfFjAS02V+iLjeGWMdmUp+I8Lf
         r55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lIK7T8B7Eyyku8RF0XNgNwtCGhRp7hkIh7+TFMDTOOM=;
        b=jGSqN7mcLKrvira/tSqgbKyag2D5tpMA4wqBy4zzf1dFdBcV5FMSLLO5dZdDgIl1th
         RuoAsSXG54+b9Fn06laUoShZMQfAeWAK04HZJCvO0WF7tgptldMdSs7OffwznYpq+wYe
         yyY5lMma/MqM3uYyrasRUbxHSRkALhujuRWn95mhEFcdV5msQcRUbbmmGdgraAXktQ7K
         T+Z6TIThZJP7eO/mwF/bBIQeMKarpL2ADUNcjLCfcRoiYqd971lYFc1p7u91UUjA1K9K
         SXxCsNnSZnIzhFOHnZR6AS3KCliC2THd9EiVYU3OcUwfxv7hyGwRySG06n8o4wRujji0
         xa8A==
X-Gm-Message-State: APjAAAVt8tWyoWT2n+n3vWT6TR9OcTIHVIVZHGN7htUfTQgUJAt1u+l2
        kDwg+vJIUrK08Ym9Rr5BtWpomQ==
X-Google-Smtp-Source: APXvYqxdpKEqSDXHq2d0D9envgFK5PeLwzFOc+DNwPACrZIGrON9Q2farga3fEcJ/DDnTT7CDyNnRA==
X-Received: by 2002:ac2:53a8:: with SMTP id j8mr6952034lfh.28.1576179398495;
        Thu, 12 Dec 2019 11:36:38 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:818:b9d7:c53b:d021:132e:26de])
        by smtp.gmail.com with ESMTPSA id y23sm3518960ljk.6.2019.12.12.11.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 11:36:37 -0800 (PST)
Subject: Re: [PATCH v2 1/6] spi: Add SPIBSC driver
To:     Chris Brandt <chris.brandt@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Mason Yang <masonccyang@mxic.com.tw>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <20191206134202.18784-2-chris.brandt@renesas.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <37c13497-d20f-583f-72d7-1e3c8a241990@cogentembedded.com>
Date:   Thu, 12 Dec 2019 22:36:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20191206134202.18784-2-chris.brandt@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12/06/2019 04:41 PM, Chris Brandt wrote:

> Add a driver for the SPIBSC controller in Renesas SoC devices.
> 
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

   Hm... I've just tested JFFS2 with this driver and got the same result as with
my own drivers:

root@192.168.2.11:~# mount -t jffs2 /dev/mtdblock11 /mnt/jffs2/                 
root@192.168.2.11:~# cd /mnt/jffs2/                                             
root@192.168.2.11:/mnt/jffs2# ls -l                                             
total 34                                                                        
-rwxr-xr-x 1 root root 18678 Jan 22  2000 evtest                                
-rw-r--r-- 1 root root 15169 Jan 22  2000 evtest.c                              
root@192.168.2.11:/mnt/jffs2# rm evtest                                         
root@192.168.2.11:/mnt/jffs2# ls -l                                             
total 15                                                                        
-rw-r--r-- 1 root root 15169 Jan 22  2000 evtest.c                              
root@192.168.2.11:/mnt/jffs2# cd                                                
root@192.168.2.11:~# umount /mnt/jffs2/                                         
root@192.168.2.11:~# mount -t jffs2 /dev/mtdblock11 /mnt/jffs2/                 
root@192.168.2.11:~# ls -l /mnt/jffs2/                                          
total 34                                                                        
-rwxr-xr-x 1 root root 18678 Jan 22  2000 evtest                                
-rw-r--r-- 1 root root 15169 Jan 22  2000 evtest.c                              

   As you can see, the deleted file is back after unmount/re-mount...

MBR, Sergei
