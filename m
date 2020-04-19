Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12DFD1AFD9C
	for <lists+linux-spi@lfdr.de>; Sun, 19 Apr 2020 21:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgDSToY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 19 Apr 2020 15:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgDSToY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 19 Apr 2020 15:44:24 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37967C061A0F;
        Sun, 19 Apr 2020 12:44:24 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q18so426949pgm.11;
        Sun, 19 Apr 2020 12:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cA6qmkeyWrcnmDv7BglbhRft1zqjTVZsRxjICTNVaNc=;
        b=mHNRyoRPXu0ih5Se4+KlXIQ/sypK/M6rYTOdovyWQuSPBd/j/bybAYlYAOGHJzuFYV
         dWUaE5ttwpOtBx52ahgKS/sno2ZAnUM/Jbxc9SzdZIQp3fApQJkwDZxIgM6fI8jZLZVw
         j2grjLoggKrbGq3vkSMU2xwiVPSprBUuLPctDUgekCYGWm82xkdgA7qguJHIIv8P9H/h
         gu5kXSesE7BQNqu2fwGnIW4nKaza7DpOR96cjv7UWr1phKea2lqgw6w2Ne4e23s6l5Vp
         wiePWuhugZrCBgDp47Oo/WZ8z7VLwa/oIN/qe1r+yCJhdh/eD82ROff0KSU4fXiVwiny
         nb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cA6qmkeyWrcnmDv7BglbhRft1zqjTVZsRxjICTNVaNc=;
        b=UbD+snsmqSnolooB4NLURF8SpuQYgTaCz6Zzeo9vhmH0xQ5UY2CW9AQa4mjnzoasNC
         kycbcKjKIhCL664Nfr5EiDLIk5CDIdF5dRol3SLBdH7fjcabQIW8GMvD5NpJ4pigsaEI
         95EApAoajPvgd+70N9sU/yOu69Beby0l2r5VcrHMEwVig/+uYfADyezQwdAFnQn0WCz8
         zyZWwyUL7i3JNPOwCWdX/5v02KRlO0XazQ0zEiZ7VMKBG5J6IixfabpzUtKjZDWoFcMu
         A8/rr/vu9yzzJgE5SQUrFEL4WsWCqoHRd9hDBelDIPGIA4Yb65uhlvOtZh2v2q4rp/cM
         7BWA==
X-Gm-Message-State: AGi0PuYsrLl6ApsaD/Q+qe5uHqWlwgqFwo7BJHvhUQkgNs7fnlR1nCOj
        zgx7Z3zgEgnIy0JVNIaDjGNMbyHK
X-Google-Smtp-Source: APiQypLTOfRQ8ljE00wRUP4agY2CBBc3JMTJ/+7RFpm5BXgIEYK17jmV8AJnDBQvT87sdku9s1t+JA==
X-Received: by 2002:aa7:8f2c:: with SMTP id y12mr14125953pfr.80.1587325462790;
        Sun, 19 Apr 2020 12:44:22 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id l7sm25358368pfl.171.2020.04.19.12.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 12:44:14 -0700 (PDT)
Subject: Re: [Patch v2 3/9] spi: bcm-qspi: Handle lack of MSPI_REV offset
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200419192339.32023-1-kdasu.kdev@gmail.com>
 <20200419192339.32023-4-kdasu.kdev@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <63176468-53b6-c11a-9e33-2ca9dd06f7a3@gmail.com>
Date:   Sun, 19 Apr 2020 12:44:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200419192339.32023-4-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Kamal,

On 4/19/2020 12:23 PM, Kamal Dasu wrote:
> Older MIPS chips have a QSPI/MSPI controller that does not have the
> MSPI_REV offset, reading from that offset will cause a bus error. Match
> their compatible string and do not perform a read from that register in
> that case.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

This patch should also have a From: that is from me.
-- 
Florian
