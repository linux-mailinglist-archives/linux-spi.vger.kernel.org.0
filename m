Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372E01FBC5E
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 19:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgFPRHG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 13:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbgFPRHF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Jun 2020 13:07:05 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D99FC061573;
        Tue, 16 Jun 2020 10:07:05 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q11so21582985wrp.3;
        Tue, 16 Jun 2020 10:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=XMRBF1iQXQfH8W0ohSSsJlVWNTVQ83/Rjd5oppXCtLI=;
        b=fivDMkIpU7zc1RLCtNnjZu694XM1KnvZyMTP4oijXbaExASqH0Oa3tHON1Oqyv9G3g
         qUhYNAnl6KORNi2nzVGi5fpj36Oibrg8Ztjk7odIHBRn1QUIogqFOoilx3AB7DrnN2ZH
         1cCM8HKluGPQCeBi6Z1UvyFgxcRHKgbFG4KDqgvMdl8RtwYvpFLGXFgfzzRX5T2bYDft
         d2ybxqYbn/wxEO5ULepxUI5kxC9qoTQcBBrNNV6mFBKOR9S3CQfWIcmI/vq7wje8cMG6
         5a+3vK/VPNoNX2vrFc9KqxKGOGPcAJQx9VZGR74wEuhi1prQjeASf0/XYWAWSRHQxYpE
         RZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XMRBF1iQXQfH8W0ohSSsJlVWNTVQ83/Rjd5oppXCtLI=;
        b=VK9PnzjxqZuHxMuupwWbjPjqrGiMlNajsHg6cVeYhioT6F5s966Jp4vXr4FaVOYIFl
         jvvgVQcGSQVRLcwRGWJAosqPiJhKIXKl+weFVQgCfiw/OczoZtrnU70PeqK+8OG9nkx/
         tyMPPwxEDXtolVn4CP+Zex0m50RhQaKziohjr8TYVvsPrhqe/j7NIofdJFM3F9HX5pk7
         +IorN3YuvWkZu11EdLng5MVOPwMX6/MS7ksEDscrd/pFcxAhMoYkwHyPA3URCayCyI5R
         N2+qvACF+fW7yRLo0UNnMSQ3pHYziOU6ZexdadyPSQHERa9RAZkThnVkuL8rlZhXDqNu
         Hy0w==
X-Gm-Message-State: AOAM532IgwTDIJ/0jKSLCrMzufw7cLXmyLk3NRc3FcWWKbgbTt9bmjgT
        yUQi63+ySi96HvgqVC3N9f4=
X-Google-Smtp-Source: ABdhPJyRfWOKefA3MT1NqEbsEMU8JAdkdhU0tJ2NJpjEQ182ORyfFqdpipoj8k/8d8CeY3edcuA+2g==
X-Received: by 2002:adf:e751:: with SMTP id c17mr3882788wrn.134.1592327224273;
        Tue, 16 Jun 2020 10:07:04 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id u4sm5008813wmb.48.2020.06.16.10.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 10:07:03 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] spi: bcm63xx-hsspi: add reset support
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        broonie@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200616070223.3401282-1-noltari@gmail.com>
 <20200616070223.3401282-4-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <fb07654a-048d-c428-545a-f5cb87cc9acc@gmail.com>
Date:   Tue, 16 Jun 2020 10:07:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616070223.3401282-4-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 6/16/2020 12:02 AM, Álvaro Fernández Rojas wrote:
> bcm63xx arch resets the HSSPI controller at early boot. However, bmips arch
> needs to perform a reset when probing the driver.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---

Same comment as patch #1.
-- 
Florian
