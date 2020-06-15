Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46101F9D57
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 18:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbgFOQ0h (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 12:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730788AbgFOQ0g (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 12:26:36 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC39DC061A0E;
        Mon, 15 Jun 2020 09:26:35 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id b5so6848373pgm.8;
        Mon, 15 Jun 2020 09:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NDYDd/+ugeWi2OA0qo/GWypzcOjmdgalgcn251DXcC0=;
        b=SNiAsO2yqZ9Hv/KEsv5fI2Apaasbxv/YcYmTaqbs38BbkVhsoIFARaUugTl2QB562C
         FTjMe8sPNFN8JTQTjP9LfjchCyWNMvGKSSFTnr8vNMO2DG9uvsQhUJmNSb997YUGbBID
         lb0YKuRUVN+Aruhceed4k1v1l+SznWXRUmMJMFo00AwqefOkAshYZFSCqgcODRztBIkK
         FQbT2Q4o7Y7yauETXMGfrNA11NCawq2kSZ4oHA5NonC0UlZdt0Pix5KF4KcTcPP1x6s6
         43xncZZhR91ElZEMOOBr9OFpN/NZTfsITps6+AaNF7h3PG2AQi0r5ZM1egJUGRaP1Ndx
         SuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NDYDd/+ugeWi2OA0qo/GWypzcOjmdgalgcn251DXcC0=;
        b=TTan93ZTON6AdDRnXX8fTEGuOMdVU695/dJlVr/FZ0JvoklxVdVKhRH5FVNERfdr46
         DqhcXzSySqBTk7VHp71CNu6uZxyPQcaOAUaQ8FNn9O9jgaz1fEDIIYwLIuHDcR98Oxg8
         M75HPr0fx+CcAmhR4ZCjHBCqAzJ7VVY14PVWaQnZCHzyMmHq1iooMfN+VQ9spNe9CUmp
         1ltZNdSnqT8h+Q8V+t9QZvjBmtTgL3YvVR+3sGEnjjAvSRwogN4tqUpqH/CW2mWZXB4n
         lXXqsevu0pTE7gHS8UaU1Pj/CsOHfZT97PIYBW2ABWVI49JoEQ8aY0a+FkYV48Uy1PQ9
         ym6Q==
X-Gm-Message-State: AOAM530zsHHSF6wGA5Hafpt+uYUOpm6OlUGjnhRK6r//v59aAlVCM0EQ
        SMGbsTRfzjwEYHd4gzOCnaQ=
X-Google-Smtp-Source: ABdhPJwfeps/GLo9QAiV36Owm6kV8ZcJvc/WUT+7cmu5HAfO301C75Byh4AxQZNNor0/yAa7xvOLSw==
X-Received: by 2002:aa7:85cd:: with SMTP id z13mr24205364pfn.321.1592238395493;
        Mon, 15 Jun 2020 09:26:35 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t186sm13503709pfc.39.2020.06.15.09.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 09:26:34 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] spi: bcm63xx-spi: allow building for BMIPS
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        broonie@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200615080309.2897694-1-noltari@gmail.com>
 <20200615090943.2936839-1-noltari@gmail.com>
 <20200615090943.2936839-3-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <ee249dc2-83e3-6f01-07ad-fc5fdf65f7a1@gmail.com>
Date:   Mon, 15 Jun 2020 09:26:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615090943.2936839-3-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 6/15/2020 2:09 AM, Álvaro Fernández Rojas wrote:
> bcm63xx-spi controller is present on several BMIPS SoCs (BCM6358, BCM6362,
> BCM6368 and BCM63268).
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
