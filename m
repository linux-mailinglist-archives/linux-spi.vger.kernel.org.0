Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D7C4210E4
	for <lists+linux-spi@lfdr.de>; Mon,  4 Oct 2021 16:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbhJDOBw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Oct 2021 10:01:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54440 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhJDOBw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Oct 2021 10:01:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 54C951FFF0;
        Mon,  4 Oct 2021 14:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633356002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K/olIZ6x8F0xsY0I9E2Cm+pj4VsB3V4lwai9QjZ0OfA=;
        b=cf/835azF0NMLsg0r5DjoHfJz9FE9GvGVALJiVpzr2OI40dtmS0gZY8XJhsSmgq89kSQ5Q
        Et72M1m4ZaqTsf3RF67l01SR+Xg/GuRD+Wz1giq2WVPPeFZoDS++ZyOhoFj/bLqn1K/LWX
        EXxQkiib2Gf7UZtDceh/ZNE2ngqSx9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633356002;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K/olIZ6x8F0xsY0I9E2Cm+pj4VsB3V4lwai9QjZ0OfA=;
        b=hhHzucHJuaOkOc/aDkpvyzMrxSxnnpGQfl2Xru/eOAK3TrmuIWzUdj/PkaqrVcwat8IbRd
        XNOKkUXBk9yKmyDA==
Received: from hawking.suse.de (hawking.suse.de [10.160.4.0])
        by relay2.suse.de (Postfix) with ESMTP id 4AB47A3C46;
        Mon,  4 Oct 2021 14:00:02 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id 3C8E9446DDE; Mon,  4 Oct 2021 16:00:02 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-spi@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: REGRESSION: "spi: add of_device_uevent_modalias support" and
 following "fix" breaks Macchiatobin
References: <YUhgbW8CiYI/rm+y@shell.armlinux.org.uk>
        <871r5j6nlw.fsf@igel.home> <YUjlwaRdmFMZHJYO@shell.armlinux.org.uk>
        <87wnna6hdc.fsf@igel.home>
        <CAHk-=wi7DB2SJ-wngVvsJ7Ak2cM556Q8437sOXo4EJt2BWPdEg@mail.gmail.com>
X-Yow:  I'm wet!  I'm wild!
Date:   Mon, 04 Oct 2021 16:00:02 +0200
In-Reply-To: <CAHk-=wi7DB2SJ-wngVvsJ7Ak2cM556Q8437sOXo4EJt2BWPdEg@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 20 Sep 2021 15:25:21 -0700")
Message-ID: <mvmlf38ubz1.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sep 20 2021, Linus Torvalds wrote:

> That is why the regression rule exists. It is NOT ACCEPTABLE to fix
> one thing, and break another. That's not a fix at all. That's a
> regression, and no amount of "but but but it fixes something else" is
> valid.

That regression has now landed in -stable.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
