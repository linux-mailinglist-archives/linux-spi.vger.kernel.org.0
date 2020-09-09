Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64812263846
	for <lists+linux-spi@lfdr.de>; Wed,  9 Sep 2020 23:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbgIIVOo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Sep 2020 17:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbgIIVOn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Sep 2020 17:14:43 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E67C061573;
        Wed,  9 Sep 2020 14:14:42 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k15so3255351pfc.12;
        Wed, 09 Sep 2020 14:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iQzKmwOo0Zi6lGT6PpXR22p/4KKjcdAVozwCuUgWRsc=;
        b=PnO5NUvEdNNV0rBBzYIX7aDeTfmGam9hgf9f/eNuGfkMxR2yCZdWQowQKPZJmtByJ8
         3GcyfKMsDo4jyXo/XnEa6jyjsBDF4Z7g+FPJMpOMTj26nlaCBbZ9U6T0YLqH5iJc9PGj
         X/lN9bUbcn8Uf+JPwfyLm1pTd6JtukCBWTkq3SiJzVshl5/kNJUF7yo+r91m0QMIopbI
         r9g5tb9rwqRERwKJ80SODvLZJtLSMGYkZzNJArihtC+OvbXZpMAvVhPNldbmkUm/XrvG
         ZcvEnxX2Q2Eq0pbb9VVksHeZmSd4ErSj4IGCJxH3Adwin5utiIt8ytoBCM9MHHK4uYwz
         YGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iQzKmwOo0Zi6lGT6PpXR22p/4KKjcdAVozwCuUgWRsc=;
        b=mPRzHKoGLFjf3cGv1Xyd5meQbP0i+Gbq8l2/xNinAyrj535QYtH25KzxwPHlMXJMaD
         9ojGyt43whWIMhvBMD0zl5wSU3WZrNGPHSKfCsEoMDvUX5JXzt9PgRvEyxMjdM6tdW6+
         Ynk0l7LVudsQ0OhGQ8lRQ4SMMmN5zRAWuV9lmEMDSMroY2B6798iettexFKFNR4mg4c+
         4MePmGelfwmP0CZireCxxpYEB0hgIl7vWWQtIRZLixUa4A+R3uw9CCd3D5WM8l+7Vqx+
         f0Qej/iCSxZ00F122cfINQ++19HRScInmiJkOBTpWctvSG7WaPRJ+9zXM8xe0tEZ3tfb
         Vong==
X-Gm-Message-State: AOAM531jw4ylwzeuLuK4LWUPuf8AzvJRblJdi4vYGJcp8IxzyGvfDFVy
        tbG41uMKcKcHeBfS0yisVngNJRwGOH4=
X-Google-Smtp-Source: ABdhPJwZ1/HSV7C6JTjYSTgF/keuH8TyMxhSCQFzc+AGr0MJ9GlUOPtKnchRs/4OoRsz4OZ1PUkp7g==
X-Received: by 2002:a63:ba5e:: with SMTP id l30mr1911360pgu.425.1599686082098;
        Wed, 09 Sep 2020 14:14:42 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 143sm3545110pfc.66.2020.09.09.14.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 14:14:41 -0700 (PDT)
Subject: Re: [PATCH 0/5] qspi binding and DTS fixes
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        "maintainer:BROADCOM SPI DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200827181842.1000451-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c8d43c72-eed7-44ae-f8f8-f8217bab5a3a@gmail.com>
Date:   Wed, 9 Sep 2020 14:14:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200827181842.1000451-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 8/27/2020 11:18 AM, Florian Fainelli wrote:
> Hi all,
> 
> This patch series fixes incorrectly defined compatible strings for the
> Broadcom QSPI controller which resulted in the strings not being
> ordered from most to least compatible.
> 
> We will need to apply some changes to the spi-bcm-qspi.c driver in
> the future to assume no revision register exist, and these patches
> are a preliminary step towards that goal.

Series applied to devicetree/fixes, sending the PR shortly.
-- 
Florian
