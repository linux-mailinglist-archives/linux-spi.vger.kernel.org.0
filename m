Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1692D4BEB
	for <lists+linux-spi@lfdr.de>; Wed,  9 Dec 2020 21:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388554AbgLIUbf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Dec 2020 15:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387695AbgLIUb0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Dec 2020 15:31:26 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3908C0613CF;
        Wed,  9 Dec 2020 12:30:45 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id f11so4036069ljn.2;
        Wed, 09 Dec 2020 12:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=85hxXWABsz718FGqeAM9X1vREp73l60SrJ0DvZJoV24=;
        b=Qgne1+qxY5AszIb9GLHu4a9cJhUe+ZOUHIIRM0txE9d2B74U3kVuJ9caHgbuqIDFKM
         LVGiRiG6WeJB5Y7UspAZLrTEVP69g7mZEXmFXWd54O5GNyyhMHebdMJG9+OTlcY26q15
         wQ+EpBhBXwq3qs2q962F2eF2b9swuMaiwFP1dmWHFzdPoiR7TV4ZjRUy/oq0hdAVcSLW
         RL8suA5DFWo1w9khYfDU6XPv1EqSkKsWHuldflhOi0WqyFd015akUyMK38Omzomao+TB
         D7if1Utly2e6M1DuANh05DG7999i+ddGcxkpbQzY1RzAhEMw/jdd3fNO9b61qAY0cl71
         nqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=85hxXWABsz718FGqeAM9X1vREp73l60SrJ0DvZJoV24=;
        b=ulvwA0abo5+mg9h+csKNyVtckgkHbu24C1ueCRGD0f1DCn3SOgpjDeUkBopihc8AvU
         yQ7TG5X2AEjfJYNphamqYe4NksY266gP39JbWEgy8kCkoqfJlpoXbZBnIac5VkyackPP
         2kqbLBAlr1jUdkcXED2tTdENPXZav7rq/Md91gemrDG0Wr6yg70hLo8v0ukOaWGUKxnC
         229VEUu0JU8o+2j+q1aIwQ4L7UvFA+J3361S+NcsEPbNkBykjnJ5Vclptycj6/OUVcmo
         8UZ2dWsDncE4W9TXK7GDIl4j1rM+BYMkQzUp/3LbXX4bBTSNV8kpyAKoZjWv8/UZU4j5
         c3Jw==
X-Gm-Message-State: AOAM530U6E8k1CC6rVWZmeEtnqQ8hHJIbncvaTEH2iIc8EVR1vAHISBl
        YpUuus9cZsE8DNRC2NOKE/g=
X-Google-Smtp-Source: ABdhPJxteF6rv6Kun+85vNIc8PKdYHSeYKl8baMUaYUrSpIuhxROi0H7txkJvhcskIdmt3cQrplVaA==
X-Received: by 2002:a2e:2e1a:: with SMTP id u26mr1707057lju.223.1607545844392;
        Wed, 09 Dec 2020 12:30:44 -0800 (PST)
Received: from mobilestation ([95.79.141.114])
        by smtp.gmail.com with ESMTPSA id 14sm278472lfq.221.2020.12.09.12.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 12:30:43 -0800 (PST)
Date:   Wed, 9 Dec 2020 23:30:42 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: Limit the spi device max speed to controller's max
 speed
Message-ID: <20201209203042.oqbcijwaxqt5aa7b@mobilestation>
References: <20201209173514.93328-1-tudor.ambarus@microchip.com>
 <20201209194636.32f4ioxxdggezklr@mobilestation>
 <20201209195420.GD4790@sirena.org.uk>
 <20201209201535.32g4kwpzo45jiqr3@mobilestation>
 <20201209202552.GE4790@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209202552.GE4790@sirena.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Dec 09, 2020 at 08:25:52PM +0000, Mark Brown wrote:
> On Wed, Dec 09, 2020 at 11:15:35PM +0300, Serge Semin wrote:
> > On Wed, Dec 09, 2020 at 07:54:20PM +0000, Mark Brown wrote:
> 
> > > Right, in general we aim to do this sort of fixup on the transfers
> > > and messages rather than the devices, I guess we might be missing
> > > validation in some of the flash acceleration paths or was this an issue
> > > seen through inspection?
> 
> > In case of DW SPI driver we just make sure the SPI-client device
> > speed set in the max_speed_hz doesn't exceed the controller SPI-bus
> > clock frequency and clamp it if it does. So the driver is safe in that
> > matter.
> 

> Ideally the driver wouldn't have to check though (no harm in doing so of
> course).

If so then we'd need to have a dedicated speed-related field in the
spi_mem_op structure, which would be accordingly initialized by the
SPI-mem core.

-Sergey
