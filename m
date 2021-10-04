Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8445D421297
	for <lists+linux-spi@lfdr.de>; Mon,  4 Oct 2021 17:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhJDPZI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Oct 2021 11:25:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58166 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbhJDPZI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Oct 2021 11:25:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 529162238A;
        Mon,  4 Oct 2021 15:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633360998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IO8dx8zJZwuXym+i6XrsBRQokvtQhLrELq0wQElXVyk=;
        b=rKzkVlT2zDszZcDOKVbLJ8xmnqHxD99UxVZH7OVC0FNlz3/LnuVF7G0pfm69qfPKe0zjh4
        GtAehLodVQ+lnBQp7XtTbGEUlSyera3a1U01NPY3+lUiglsPKuPGVWX8m3o/KUq4vxq0U+
        bPu2+HkxgsEQBEzXmWo202DQGQmnx2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633360998;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IO8dx8zJZwuXym+i6XrsBRQokvtQhLrELq0wQElXVyk=;
        b=slZEwKTFOyML2DspxtoSPebW7X3WpKGHMOpbtEyR+f3zKy5SKFucgLB2GHwfYnysMnK6CQ
        pTyf5EELjVAt6YCQ==
Received: from hawking.suse.de (hawking.suse.de [10.160.4.0])
        by relay2.suse.de (Postfix) with ESMTP id 48757A3E3D;
        Mon,  4 Oct 2021 15:23:18 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id 3A931446DDE; Mon,  4 Oct 2021 17:23:18 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-spi@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: REGRESSION: "spi: add of_device_uevent_modalias support" and
 following "fix" breaks Macchiatobin
References: <YUhgbW8CiYI/rm+y@shell.armlinux.org.uk>
        <871r5j6nlw.fsf@igel.home> <YUjlwaRdmFMZHJYO@shell.armlinux.org.uk>
        <87wnna6hdc.fsf@igel.home>
        <CAHk-=wi7DB2SJ-wngVvsJ7Ak2cM556Q8437sOXo4EJt2BWPdEg@mail.gmail.com>
        <mvmlf38ubz1.fsf@suse.de> <YVsP8KpJqISGw7jk@sirena.org.uk>
X-Yow:  That's a decision that can only be made between you & SY SPERLING!!
Date:   Mon, 04 Oct 2021 17:23:18 +0200
In-Reply-To: <YVsP8KpJqISGw7jk@sirena.org.uk> (Mark Brown's message of "Mon, 4
        Oct 2021 15:30:08 +0100")
Message-ID: <mvmh7dwu849.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Okt 04 2021, Mark Brown wrote:

> On Mon, Oct 04, 2021 at 04:00:02PM +0200, Andreas Schwab wrote:
>> On Sep 20 2021, Linus Torvalds wrote:
>
>> > That is why the regression rule exists. It is NOT ACCEPTABLE to fix
>> > one thing, and break another. That's not a fix at all. That's a
>> > regression, and no amount of "but but but it fixes something else" is
>> > valid.
>
>> That regression has now landed in -stable.
>
> Like I said previously please stop this, it is not helping

Which part of "It is NOT ACCEPTABLE to fix one thing, and break another"
did you not understand?

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
