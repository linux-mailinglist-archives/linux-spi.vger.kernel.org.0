Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA5142A8BE
	for <lists+linux-spi@lfdr.de>; Tue, 12 Oct 2021 17:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbhJLPut (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 11:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbhJLPus (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Oct 2021 11:50:48 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CA8C061570;
        Tue, 12 Oct 2021 08:48:47 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id m67so3557533oif.6;
        Tue, 12 Oct 2021 08:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:from:cc:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=2qmD6+vaMWoQqWaeUIWFicVZqs7HNdeMB3LTPfFG2Pw=;
        b=UCC+nhX5bSHDhee9N++ybcRDdn1tsy2g0Lyx69LtGJlBj+RbxZAiCOynoXOpQN0AY1
         r2pfH2GqpkAbDNXhPL6tRF6wZ8ty36ZI8jLAf+xFlnEFXMjS0Uv0hCit12U7HcozeEUw
         eo9BKXA/Sky5b73PBfE3ECtERl7pNIgs5y9vUAORqhCwQKu1T4LoDRny6MGfk+TxBaZP
         hdgzDIopexpui2hkXQB2Tbppw+s1/iW00dEyCBtPffGnlg/za65OHeH6ApZIa1UiMDoQ
         /bLRRrwmYlHqz5fQqiiKnnDC0yZYkj9rklQ/veGvR8+KkM6iudUitng/LKtPPc5FTnbM
         Zy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:from:cc:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=2qmD6+vaMWoQqWaeUIWFicVZqs7HNdeMB3LTPfFG2Pw=;
        b=31p+A3hjdMSt8hJShlefk+aavGLUW3DDEVqtMaszPK1ZzZPvy+QUghhoRWYD8uaMdX
         ZD/YpAow9dsBm5FtUmFzGZ0spltvZRgamMQDR5kK4g1oxNvVVSBu9BCM31SNWQFOwYd8
         ZjdkONXYln2FaTC/tBFM3XdmLhUXmHm2+CgHXekWYQZtrck8dvD+bbCBwkEEsAq2nAgA
         AqKX+AT4m0H+utiCkqbUo0/uYd0qKN3Pt3EbLDYLWMeDJBsRxTYnmVbkFugqVl3TpDLP
         Lp3shvOt6w1nM1hWcEpymcdkPdJIQcp3dnfhpOZzjMbX2xM0ndOsDCv0MIXsCLR0t3/C
         csbA==
X-Gm-Message-State: AOAM532rVU6f9Xb7EY+7Rn1rDOk/3iMPnZP5d302JxVYsbOhTwX10FL2
        uxXGKTgfDjrNvNM3wExjf4zLq/tGdVE=
X-Google-Smtp-Source: ABdhPJxxagBPIlYS6howJFc4u343Lob3u7I/z0qlk/YUtuZP81zVQcRfsd2EVH9ZSoNCMlgZNhlbnw==
X-Received: by 2002:aca:3e09:: with SMTP id l9mr4154731oia.131.1634053726366;
        Tue, 12 Oct 2021 08:48:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bf21sm1730995oib.4.2021.10.12.08.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 08:48:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Mark Brown <broonie@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Cc:     "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: spi-tegra build failures in -next
Message-ID: <dbd820df-45b8-8d42-d482-cd5d9a2b22f6@roeck-us.net>
Date:   Tue, 12 Oct 2021 08:48:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

I see a number of build failures in -next:

Building alpha:allmodconfig ... failed
--------------
Error log:
<stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
drivers/spi/spi-tegra20-slink.c:1197:12: error: 'tegra_slink_runtime_resume' defined but not used

Looking into it, the problem seems to be a bad conflict resolution between
the following two commits.

efafec27c565 ("spi: Fix tegra20 build with CONFIG_PM=n")
2bab94090b01 ("spi: tegra20-slink: Declare runtime suspend and resume functions conditionally")

Granted, Linus' solution is better than mine, but it looks like the second
__maybe_unused in commit efafec27c565 got lost in spi/for-linus due to a
later merge. Would it be possible to either fix that up or drop commit
efafec27c565 from spi/for-linus ?

Thanks,
Guenter
