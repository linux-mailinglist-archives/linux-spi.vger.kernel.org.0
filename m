Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697E34879E8
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jan 2022 16:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbiAGPuJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Jan 2022 10:50:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53236 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239713AbiAGPuJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 Jan 2022 10:50:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 148B361F61
        for <linux-spi@vger.kernel.org>; Fri,  7 Jan 2022 15:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510AAC36AEB;
        Fri,  7 Jan 2022 15:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641570608;
        bh=0Kz7TKSAuDit1G1SsKA5e/8VJMbWCHyAiB6zNzirECM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ig/9f9tuBoNbgKmh3pvIzwZEd5N1Nvf/enXvbJqecSzVsKfwbh646irizZV2mzbH6
         KDuYOpbeP6L2rshl1M5o+F+zer8TzBld4XB4RZqq13sEHFqw7RGTkKLoBwkMSU3+0g
         rGR6NLEDQGnzYSSZi3aMJmBqiOR31Twj/D0V9scnZ4LZt/Id0kDaBLU2sMhkuB7Z6a
         WBDcq9mUZUg4IY8qtxtOraR5fE25iOIDZqOHEaewriEDjofQB5uVp61g8zUV2YgUQ9
         lW1xOT7Nz/y+L2KK4482gZPlBGE2nK3vGIb0CkDKIi8noEgnKnw9YHhWrtnRcabHJ/
         RsfC30KZKe3NA==
Date:   Fri, 7 Jan 2022 07:50:07 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH] ptp: don't include ptp_clock_kernel.h in spi.h
Message-ID: <20220107075007.4cb5bbac@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <Ydgy2TAodUMYG2EW@sirena.org.uk>
References: <20210904013140.2377609-1-kuba@kernel.org>
        <20210906113012.GA4309@sirena.org.uk>
        <20220106195621.0315ef77@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <Ydgy2TAodUMYG2EW@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 7 Jan 2022 12:32:25 +0000 Mark Brown wrote:
> On Thu, Jan 06, 2022 at 07:56:21PM -0800, Jakub Kicinski wrote:
> > On Mon, 6 Sep 2021 12:30:12 +0100 Mark Brown wrote:  
> 
> > > Please submit patches using subject lines reflecting the style for the
> > > subsystem, this makes it easier for people to identify relevant patches.
> > > Look at what existing commits in the area you're changing are doing and
> > > make sure your subject lines visually resemble what they're doing.
> > > There's no need to resubmit to fix this alone.  
> 
> > Mark, was this ever applied? I don't see it in linux-next.  
> 
> If it's not in -next it's not been applied.  This is one of the hazards
> of sending things with random subject lines, they get buried and missed
> much more easily...
> 
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so 
> on so unless there is some reason for urgency (like critical bug fixes)
> please allow at least a couple of weeks for review.  If there have been
> review comments then people may be waiting for those to be addressed.
> 
> Sending content free pings adds to the mail volume (if they are seen at
> all) which is often the problem and since they can't be reviewed
> directly if something has gone wrong you'll have to resend the patches
> anyway, so sending again is generally a better approach though there are
> some other maintainers who like them - if in doubt look at how patches
> for the subsystem are normally handled.

I think it's best if I take this patch via networking, then. It's
trivial and the merge window is afoot, anyway.
