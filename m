Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316CF1AD192
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 22:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgDPUz0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 16:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727952AbgDPUzZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Apr 2020 16:55:25 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7763BC061A0C;
        Thu, 16 Apr 2020 13:55:25 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g6so2203384pgs.9;
        Thu, 16 Apr 2020 13:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tRp4sksgDku5T1RHONV+cHmwg4VeG23KppLeZFt7ais=;
        b=OOoCdSRUwaAYiBhJa6PT3YEctiEoqdhPlElRmYMDKKMbBeuk01GkiGtDiFL2gll5R+
         PyRTmPEtmmMT80RUx6x0V1QX+xYCxducVthmOBZRcVjhCbn38YePvR482/y5QAUqBUcG
         pqPKMDvJOp8bc92uIlfTJMIj4h4h7d+6B1xngK1q4ER7sqUXhKcJtCi7i1heNLJeitmY
         kG+6QB39al+TS0eQT2J1lfL5Om60QtihOTuHJ71sZ1SmzdDcIYjyWf0EzA+k/IR+i1Wg
         UyHAO9Q+1UAcODvkzPm3Sptw8pEycAt2wzvPCjGRvJePaf/c9RCwaSHfgzRPH16psE61
         Mq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tRp4sksgDku5T1RHONV+cHmwg4VeG23KppLeZFt7ais=;
        b=TxbhuxoK1+flFF8zHdoPgYu2wTHSIfJ57YbSU7TcbBNqXArt69mb30tndQDq4QKWzp
         6co+610TKCKNRj2RRAe8yjvPs83EfwEdH9qN1gVehz3DT1REsm5p7weTDpSTVXCArvGl
         8G6Iv9OW5dn83+P7opA/8dDS3TJeuIu5I9W0WctiXuj8LZV0wyPUgMGjjzamRPg7SkKW
         f3alEoorsvl/B6tOn1pAYLt+jjfdZ/nILXCR53O6Ti5NypVx9o8dtSg7lHMGAtY3Yt/1
         rx3gEOw/4SReNjapd95AOY0RWTUjUwAswvQkN55Bb3wVzR5DSFj7W5bDcCY6lV9lHMvC
         rGFQ==
X-Gm-Message-State: AGi0PuY0ttS1tRBCbIh/MyJQnhP9JGOpQ1YiJAF8nSfO7HMU1zKdzAlR
        4DssWadehORr80H6IWMBr6DfpBlV
X-Google-Smtp-Source: APiQypIcH5Hx6ZnsZmvuRfWbTPXfSA0gVMA650+jd9c+8exLd5z1RJGE3UdSg6iZkVcjuzoeu5B/tQ==
X-Received: by 2002:a62:7656:: with SMTP id r83mr3542746pfc.71.1587070524332;
        Thu, 16 Apr 2020 13:55:24 -0700 (PDT)
Received: from [10.230.188.26] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ml24sm3210343pjb.48.2020.04.16.13.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 13:55:22 -0700 (PDT)
Subject: Re: [Patch 1/9] spi: bcm-qspi: Handle clock probe deferral
To:     Mark Brown <broonie@kernel.org>, Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200416174309.34044-1-kdasu.kdev@gmail.com>
 <20200416174932.GP5354@sirena.org.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <7b2db6ed-1aab-4c61-e519-a73d9e3af454@gmail.com>
Date:   Thu, 16 Apr 2020 13:55:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200416174932.GP5354@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 4/16/2020 10:49 AM, Mark Brown wrote:
> On Thu, Apr 16, 2020 at 01:43:01PM -0400, Kamal Dasu wrote:
>> The clock provider may not be ready by the time spi-bcm-qspi gets
>> probed, handle probe deferral using devm_clk_get_optional().
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> 
> Did Florian author this patch or you?  The signoffs look like it was
> him.

I believe I did author that one ;)
-- 
Florian
