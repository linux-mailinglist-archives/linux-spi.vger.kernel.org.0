Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE1E3CF204
	for <lists+linux-spi@lfdr.de>; Tue, 20 Jul 2021 04:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbhGTBuu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Jul 2021 21:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348840AbhGSXQw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Jul 2021 19:16:52 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4315BC061574;
        Mon, 19 Jul 2021 16:50:24 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 37so20953059pgq.0;
        Mon, 19 Jul 2021 16:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OWc8hqQQpNq22ewTu2Cne5FSxOLf7rSW/vePnOSRjJ4=;
        b=q8msN0xI4jxFBIgNFs30yYsMhOay4C/hsPBXdeze1/0ngvN7ZksrLKVS5fGOTo6qyK
         kfhDA9onlyhZjJhFchmmSYkIRC9eeahGVQ6jJm6tdE+wsfq94/G1P4fKD0SekqSUMhz+
         3FTR4EpkqXB8rFY1sZdB39K9Yl8pm8NGrehkFWgCmHrchncUvF/D+xCEZQGSeX/QWyZt
         D8TzotpRH1DvUoqASQrLHqrRqvSU8vSLsTP2IR2MiODbMzY33IBmh8qTVW1iwJpVCcRZ
         rIVmVd9GeWu6p0he5kDaDJh5iY/mMABLqCHG7RhKvDIubba9BfC53mHNwKID8VDzfihy
         tNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OWc8hqQQpNq22ewTu2Cne5FSxOLf7rSW/vePnOSRjJ4=;
        b=ntaMB0R61y9PGooQdSqWNLPs1JrkH2h3oQoQhMeHxJHNGaqkQ0TulkoQB6ff2rcKBh
         j6fiIpg9zSxEo0Z/FQtOCQlaQ3AusA0YHK7IovARhEPF8kHDfcbpGq5PqB/8YUBxexpF
         9S+J6XtLb0FNlbzLyqkEUQVbZ+t/SYQ+d7Djc8qKT1y2lqd6HfqENshj4bkhdyj9q14b
         Io2eVeNn1JgbkqL924OmW20iHZWw72BqahH03Qz37xTwBxedCv0Cgf6UTyCTpPo34Fdb
         YtVcEcE9Euu4AORoN+yFIMhRCWrneWBR9z1BJu+7Ysj/gwOaJmYF0gnGxA1v6X6wgnhw
         bMUQ==
X-Gm-Message-State: AOAM533Lxy03dGztMmacDsiTtcBK19P/5J+Uce7hTjCNdDmmgADdr9WV
        sy8hnMYGLGB4g8gOeSTVhp0=
X-Google-Smtp-Source: ABdhPJycgNRiFYQmS7TXzt8et/xrcIHB2RLODGj4JURwPu1gXgYo3rKqFp9De8ZGbDEboYDOC9bb0Q==
X-Received: by 2002:a63:48f:: with SMTP id 137mr27964585pge.257.1626738623772;
        Mon, 19 Jul 2021 16:50:23 -0700 (PDT)
Received: from [10.67.49.104] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id x6sm25082950pgq.67.2021.07.19.16.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 16:50:23 -0700 (PDT)
Subject: Re: [PATCH 1/1] spi: spi-bcm2835: Fix deadlock
To:     alexandru.tachici@analog.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, broonie@kernel.org
Cc:     nuno.sa@analog.com, bootc@bootc.net, swarren@wwwdotorg.org,
        bcm-kernel-feedback-list@broadcom.com, rjui@broadcom.com,
        f.fainelli@gmail.com, nsaenz@kernel.org
References: <20210716210245.13240-1-alexandru.tachici@analog.com>
 <20210716210245.13240-2-alexandru.tachici@analog.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <77c67af2-e9fa-cc27-b44e-8c412b71cfc7@gmail.com>
Date:   Mon, 19 Jul 2021 16:50:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716210245.13240-2-alexandru.tachici@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 7/16/21 2:02 PM, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> The bcm2835_spi_transfer_one function can create a deadlock
> if it is called while another thread already has the
> CCF lock.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> Fixes: f8043872e796 ("spi: add driver for BCM2835")

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
