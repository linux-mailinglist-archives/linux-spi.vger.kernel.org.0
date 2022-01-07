Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD2A48718B
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jan 2022 04:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiAGD40 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Jan 2022 22:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiAGD4Z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 Jan 2022 22:56:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5660DC061245
        for <linux-spi@vger.kernel.org>; Thu,  6 Jan 2022 19:56:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26A35B817F0
        for <linux-spi@vger.kernel.org>; Fri,  7 Jan 2022 03:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2867C36AE9;
        Fri,  7 Jan 2022 03:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641527782;
        bh=j8fO3H7f5F4ggwtzYQsCQ98kUnHPgGiFqYRIpmha6sA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZJ1HvnxZPXO/jccaEaOVbosNlGsx+EHqXQxEPX1PBVzyU10C36M5Txkxyz046hz/h
         9LrLRJMMYDj+aqW6gwiiMhO7LIdxzeniwL/Crff1inGCLowIxAM2sfzc7Q2kqMDAoI
         +uoOSrxBVoA0TTsjRz+43OS3ZnDXhXn5cZvk5G1Xqp9a30lzcXrs2P0dvl4kN90MmD
         RbGPaaLS8qn80wM3Sh9wUaGc2gHw2GQH61oxXqJx8YwnCAoT+1XOpH/mSJwSeyxJW0
         AiMMOZ936KhtnjuGol6unVXenDEVRHcBRjmIyn04oUsRB1bYsAZqDtrRP9c/GVWhzu
         6R3fzQdUt2YUQ==
Date:   Thu, 6 Jan 2022 19:56:21 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH] ptp: don't include ptp_clock_kernel.h in spi.h
Message-ID: <20220106195621.0315ef77@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210906113012.GA4309@sirena.org.uk>
References: <20210904013140.2377609-1-kuba@kernel.org>
        <20210906113012.GA4309@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 6 Sep 2021 12:30:12 +0100 Mark Brown wrote:
> On Fri, Sep 03, 2021 at 06:31:40PM -0700, Jakub Kicinski wrote:
> > Commit b42faeee718c ("spi: Add a PTP system timestamp
> > to the transfer structure") added an include of ptp_clock_kernel.h  
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

Mark, was this ever applied? I don't see it in linux-next.
