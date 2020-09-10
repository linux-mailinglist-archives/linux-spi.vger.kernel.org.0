Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0A5264D65
	for <lists+linux-spi@lfdr.de>; Thu, 10 Sep 2020 20:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgIJSlg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Sep 2020 14:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgIJSSa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Sep 2020 14:18:30 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6754BC0613ED;
        Thu, 10 Sep 2020 11:18:21 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 67so4655701pgd.12;
        Thu, 10 Sep 2020 11:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gG+fuMGEqnPLk7Bo+tjlREXOWrP6LnZTNp4lY+I/XBQ=;
        b=RfNPYQ0IMWGuVftlfbq63KXkfZ4nENjXeVCkHwxybJksNYRjTqa45Kd4xB4cDmp1mH
         ekdt75q52/StE9ky15srFtmEfHWQjfQp0oH8PtY5qQuvMdGaNqXVSv3LMTyg90Wpeijj
         3dG9t/v0u+s7ew+jlHXh91XhEJNgaUpOmhjmXUsmycqF3u3hW7ptqn6LzKv7uBxuOQa+
         9mKFhZJHsCQrNXUeZxY+QZrbFsZLxN8jpmaV4EukWX5RvP8xj3Wi7Z/uUhVwZUIc0lQk
         gtyYvJf7H+vWVPoksIr7R6qPVcbd08Zusk2I4HEGzS5OiKsAdeykYVbwG4j/IDZjDIxM
         bPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gG+fuMGEqnPLk7Bo+tjlREXOWrP6LnZTNp4lY+I/XBQ=;
        b=AYivvxeoT0uXQKZy9gy31+s0ZRSI0XZIN1epi4VYcv0zmDracMWHhqtbLXB5fNa64b
         63x56h4BvN5/o5masjJo5MdrDKA0SO/DOB6jb5w4TjFSNmBoBG8rEKWZdCBXyAri/f1q
         t6behVQMLgg7TBw+4l/+jsI3O7s0WTi562c/RhN4ewTx8jYvg21/MIVTcFWFh57WeOZG
         SOvrhulBNKiQQUlKivu6vhtIUWwvaXuVZfrIWICVMcZyGxXv0ZbD9nt3skZb83OTuiy+
         Vawoto0OWHO5DMtDVdHOcFd3nOlCGuR7IL3VpELCXaySwjQHHjDGsosJYG0Sa5z/R2Tb
         0v2A==
X-Gm-Message-State: AOAM530QS3KIZlhctE5EDe/HkbWsls0es4iBq5iaHDk/TMXMUEzAdiVU
        LOtpdaivxauK/4jtFg3GlZo=
X-Google-Smtp-Source: ABdhPJwoOV6PL/qF/81ukPiLOopjSpVEVjK+cK4tEqnBpZRsa4JZlzuJfInL5Pw0iZjGOICBlgQdsw==
X-Received: by 2002:a63:fa10:: with SMTP id y16mr5469723pgh.304.1599761900909;
        Thu, 10 Sep 2020 11:18:20 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v4sm2468345pjh.38.2020.09.10.11.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 11:18:20 -0700 (PDT)
Subject: Re: [PATCH 2/4] spi: bcm-qspi: Add compatible string for BRCMSTB 7445
 SoCs
To:     Ray Jui <ray.jui@broadcom.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <20200910152539.45584-1-ray.jui@broadcom.com>
 <20200910152539.45584-2-ray.jui@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <34f96a04-a8cd-5cd8-da25-9202c95cb15a@gmail.com>
Date:   Thu, 10 Sep 2020 11:18:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200910152539.45584-2-ray.jui@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 9/10/2020 8:25 AM, Ray Jui wrote:
> Add compatible string for BRCMSTB 7445 SoCs and indicate it has MSPI rev
> support.
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
