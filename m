Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34C345A996
	for <lists+linux-spi@lfdr.de>; Tue, 23 Nov 2021 18:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238425AbhKWRGk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Nov 2021 12:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238234AbhKWRGk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 23 Nov 2021 12:06:40 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B835C061714;
        Tue, 23 Nov 2021 09:03:32 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id g14so95079079edb.8;
        Tue, 23 Nov 2021 09:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/65LbMuSLaSvrlVJdGK0y4BrkdQLbTsAV6bRPfikGpE=;
        b=MRRORz5nCO9XijsLW1YQautz+aFc4F0fC2TYCwa4Vu4ojCtQ1q4UVwbAdhgwNaBCah
         jPu6htFVUeYvtXvem9glxuaouL3cEBedVcLRjgSApdSB8H6GXx8lmkGpXKktR4wnI8rT
         ASgwzRupnGViUy1IwPpNaZ0A/i8wF8hyHLDrzL/9df3PqibMll365fjMSWxPxjWDiiQN
         fbN3P7GYSrv/r8ezGj54DUcX8paa216VyvkTK5UKpnzKmKcTxvjPCGMXK/B4k2aD6IHk
         tHO3Txjj5ddrB6MKKcO3CEuvWcH+16ZvdIzXhmiK6zBeDCyT6XBXjg5wbeEunoHitIFt
         WPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/65LbMuSLaSvrlVJdGK0y4BrkdQLbTsAV6bRPfikGpE=;
        b=mYJrnA9LoFmo33qTN0inuiVY/gO+Ox6L6Vu6CPIKUnkQstdP/1b01q0VMDkiXRG8Uj
         bwFpEbRDCarNhZ6308SYpINhEQNBaS4uHArktRX7/KI3nDh04g4hLNM6//4KgNtqFRuQ
         SxczAkqdqQcsvVLn0IRgiFlqKlJuxJbfHzi5q2II2Dd8tcNeBRW8PX5BWniusY1spb9y
         CXNWs2nnfPb3QWL7J53+wTLUmLt3Qa6682uR0yMzYgjZM8qmgIXCTzLS2gmbkIxmI5LZ
         Ap0ORxYazmvHCU+4VcuGdHw8D+SWD+TSwrsUrCDjdIKE3BK7ixnUz6UesNS14d04K6Et
         UuJw==
X-Gm-Message-State: AOAM5317h3drNNqplWbWTBBHILZUMTatr1N+VoKvkRHnR573ruYoqvx0
        1Mu5Cs1akuy1u6edHUHzQ+qsZ8L7sFG+6Q7xLmU=
X-Google-Smtp-Source: ABdhPJx8ZMgQqsvg+exvEAuqvWnll3gpdXORrquqkEfioXnJ7HbC9hEKYaw2H6z+prDIB9QxbQ1XZf7zA89XkwnnNoQ=
X-Received: by 2002:a17:907:9196:: with SMTP id bp22mr9207064ejb.69.1637687008680;
 Tue, 23 Nov 2021 09:03:28 -0800 (PST)
MIME-Version: 1.0
References: <20211123170034.41253-1-andriy.shevchenko@linux.intel.com> <20211123170034.41253-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211123170034.41253-2-andriy.shevchenko@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 23 Nov 2021 19:02:51 +0200
Message-ID: <CAHp75VcxxJe3dogyemBwERirEPCGYVmG1PFN8TknhsTL8swLjg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] spi: Replace memset() with __GFP_ZERO
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Nov 23, 2021 at 7:01 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> krealloc() as any other kernel memory allocation calls accepts GFP flags,
> one of which is __GFP_ZERO. Hence, no need to call memset() explicitly on
> the reallocated buffer.

This one is already applied, seconds before I have sent it.

-- 
With Best Regards,
Andy Shevchenko
