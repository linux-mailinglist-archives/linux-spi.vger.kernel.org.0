Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A907E4133A9
	for <lists+linux-spi@lfdr.de>; Tue, 21 Sep 2021 15:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhIUNDv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Sep 2021 09:03:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33932 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhIUNDv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Sep 2021 09:03:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 62F0822115;
        Tue, 21 Sep 2021 13:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632229342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cK2L+f+R57htk/c2VOqRlYiPsD7+zNOxkzsFUwwAwjg=;
        b=N1QUbzx8UsJswBCrDBrhK1f5YOZuMtJul0qi4N1FwnxQLjBje6vtIxHLxzlFoQBRdFA7si
        6dFxgv5ZgOcVK8D8HAb1RI1kjxOUMPdyBQTmYP8tKO48UUb5WHnqoUpk34kZZS2Qob0VO8
        op9OYebuM2bV7HHhKtjXnwOhkWIrP48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632229342;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cK2L+f+R57htk/c2VOqRlYiPsD7+zNOxkzsFUwwAwjg=;
        b=zUXy5J+CM1VJlF4oMK/2026OS+5jPzxKfSoFZDElvCb87RQVC4RNu8ZdX4gqByjpP20vin
        5tVfX6qsQmqyrgCg==
Received: from hawking.suse.de (hawking.suse.de [10.160.4.0])
        by relay2.suse.de (Postfix) with ESMTP id 57D20A3B96;
        Tue, 21 Sep 2021 13:02:22 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id 45CF8445C9A; Tue, 21 Sep 2021 15:02:22 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: Re: REGRESSION: "spi: add of_device_uevent_modalias support" and
 following "fix" breaks Macchiatobin
References: <YUhgbW8CiYI/rm+y@shell.armlinux.org.uk>
        <871r5j6nlw.fsf@igel.home> <YUjlwaRdmFMZHJYO@shell.armlinux.org.uk>
        <87wnna6hdc.fsf@igel.home> <YUkOdoqccsbEh08C@shell.armlinux.org.uk>
        <87sfxyfklo.fsf@igel.home> <20210921122228.GB9990@sirena.org.uk>
X-Yow:  This PORCUPINE knows his ZIPCODE..  And he has ``VISA''!!
Date:   Tue, 21 Sep 2021 15:02:22 +0200
In-Reply-To: <20210921122228.GB9990@sirena.org.uk> (Mark Brown's message of
        "Tue, 21 Sep 2021 13:22:28 +0100")
Message-ID: <mvm8rzqw081.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sep 21 2021, Mark Brown wrote:

> On Tue, Sep 21, 2021 at 09:34:11AM +0200, Andreas Schwab wrote:
>
>> Reverting them will break module autoloading that previously worked.
>> This is a _regression_.
>
> We know. 

Apparently, Russell didn't.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
