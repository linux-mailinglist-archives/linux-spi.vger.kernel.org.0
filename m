Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631411FBC8A
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 19:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgFPRPV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 13:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbgFPRPV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Jun 2020 13:15:21 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A266C061573;
        Tue, 16 Jun 2020 10:15:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y20so3904218wmi.2;
        Tue, 16 Jun 2020 10:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QhW4rw2V54gZCDa7P3fSu9pAuZ4kviStAGejWDMKSo0=;
        b=qygW2ymDas8q+jeylYfPDMqo7XiGmV5+pNUvPZFHlkz5KAb3DjGnLApVeTOSrNlGVO
         OB1hXsf1qurMomCesWbFlg5DXdsldg5MLFLpNL+j+mtwBwaleSrKbKexFdZwvTxBzPg+
         LV0qJCSMDM/NPXQRo5x8XC07tCctyaTlCSo4Z1Jazmmd2iVCBGhP9MoUC7RMuTN/KxRU
         HaXDuo0+8aJ2ub8ogpP+vNWtI+p5q/gYSDDxlnIMPknwaG7vi11hWaya790BHfWmjUbg
         YDgEzWaI22I7Qdb81ZGbktKoZLNBrXGlVsZhGmK4yBwMiWoarPniLQ5Y5e9X7N9Zp/re
         9TYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QhW4rw2V54gZCDa7P3fSu9pAuZ4kviStAGejWDMKSo0=;
        b=WkLx2HC6WlCFNC+gYi+nw2yzFjB3Qh8dSHnl3cXlouwFdYWhM4QLDIa4K9/K4kRuKs
         YSVeICl3mgc4I96JrjB8hLU98u/pKsma5JCZtGwQZj2kJbywt1S1PaFg/2KLaAST/MT/
         I0kfS8jTLO0NGXsT18nXHsqzL8MWHAV+k/+agO4tqy0fcDJqJpgoVWZk+jBi/yNuxR+q
         RwIRayn4Yap/UOf/3/23irL0lByLlgYS/U140VTydIm8HH5AEPvV609I/I766VR6BKAQ
         DFriGS5gkWyo+T3zEuYKtZ8oqxxRYKQW7Yupq+sfczErWJpOsOiz9XTVRxbVjotdCeTt
         hb8g==
X-Gm-Message-State: AOAM532IsZPiJpJj+0cYSQznlzZYMlI8YVWaL9UnWY42pxcRQ8agIAvU
        7jxX7MmdwCq880/XvQkSG90=
X-Google-Smtp-Source: ABdhPJxVlDlAV5HqWOP7dAzfshi970rv9Vt2Muv1ppjEZjKtAq5ykLnGvW6ShUOisFK+eJLQZypRNw==
X-Received: by 2002:a1c:2082:: with SMTP id g124mr4423504wmg.21.1592327719828;
        Tue, 16 Jun 2020 10:15:19 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id t14sm31469418wrb.94.2020.06.16.10.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 10:15:19 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] spi: bcm63xx-spi: allow building for BMIPS
To:     Mark Brown <broonie@kernel.org>,
        =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        p.zabel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20200616070223.3401282-1-noltari@gmail.com>
 <20200616070223.3401282-3-noltari@gmail.com>
 <20200616170724.GT4447@sirena.org.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a6edd50d-db3f-8988-157c-ff66e2fd474a@gmail.com>
Date:   Tue, 16 Jun 2020 10:15:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616170724.GT4447@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 6/16/2020 10:07 AM, Mark Brown wrote:
> On Tue, Jun 16, 2020 at 09:02:21AM +0200, Álvaro Fernández Rojas wrote:
>> bcm63xx-spi controller is present on several BMIPS SoCs (BCM6358, BCM6362,
>> BCM6368 and BCM63268).
> 
> Please do not submit new versions of already applied patches, please
> submit incremental updates to the existing code.  Modifying existing
> commits creates problems for other users building on top of those
> commits so it's best practice to only change pubished git commits if
> absolutely essential.
> 

In Alvaro's defense, you applied the patches despite me requesting that
specific changes be made (use the optional reset control API variant).

Having a FAQ entry about what your expectations as a subsystem
maintainer are (ala netdev-FAQ.rst) could save you time along the way.
-- 
Florian
