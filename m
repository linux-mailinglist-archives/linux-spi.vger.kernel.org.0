Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2DE412F87
	for <lists+linux-spi@lfdr.de>; Tue, 21 Sep 2021 09:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhIUHfl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Sep 2021 03:35:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53424 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhIUHfk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Sep 2021 03:35:40 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 40C631FEA3;
        Tue, 21 Sep 2021 07:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632209652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=miN0rmZnYmhXdF8+vHO3OiIeCYH8jWQmr3BsvKFUnjY=;
        b=s6AtVW+ZLxvrHrUMVH3ZjBtFlpDM1J6nAMojUw3Mw1FQt0+wbHv1GFBfPApxL32LLXPyvt
        tgwCRWVHuCDbAwYZz8rlnspk5Gfj/a94lX6YmPGpUIETigas33ghHbNKwLQKK6iTE3/em/
        EjDRpxcH9OmeilemRVL3vqyraWuQi6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632209652;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=miN0rmZnYmhXdF8+vHO3OiIeCYH8jWQmr3BsvKFUnjY=;
        b=pef4Vsbppi2ke6WXsRkA62SzWbywDyooyNmubP76fR7HlrQ6DkYKUej5D0nYp40Ro5uBip
        b7aCyagpKtg0k5Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E97C313B0A;
        Tue, 21 Sep 2021 07:34:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NjYPN/OKSWEmCgAAMHmgww
        (envelope-from <schwab@suse.de>); Tue, 21 Sep 2021 07:34:11 +0000
From:   Andreas Schwab <schwab@suse.de>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, broonie@kernel.org,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: Re: REGRESSION: "spi: add of_device_uevent_modalias support" and
 following "fix" breaks Macchiatobin
References: <YUhgbW8CiYI/rm+y@shell.armlinux.org.uk>
        <871r5j6nlw.fsf@igel.home> <YUjlwaRdmFMZHJYO@shell.armlinux.org.uk>
        <87wnna6hdc.fsf@igel.home> <YUkOdoqccsbEh08C@shell.armlinux.org.uk>
X-Yow:  Yow!  We're going to a new disco!
Date:   Tue, 21 Sep 2021 09:34:11 +0200
In-Reply-To: <YUkOdoqccsbEh08C@shell.armlinux.org.uk> (Russell King's message
        of "Mon, 20 Sep 2021 23:43:02 +0100")
Message-ID: <87sfxyfklo.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sep 20 2021, Russell King (Oracle) wrote:

> Yet you say without your change module autoloading doesn't work - that
> may be true for you, but the point here is that:
>
>    Your change plus another during the 5.14 cycle broke previously
>    working module autoloading. It broke a previously working setup.
>    This is a _regression_.
>
> Maybe you could explain why you think otherwise - and possibly accept
> that it _did_ used to work for others.

Reverting them will break module autoloading that previously worked.
This is a _regression_.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
