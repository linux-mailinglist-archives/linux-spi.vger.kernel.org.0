Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29D2412895
	for <lists+linux-spi@lfdr.de>; Mon, 20 Sep 2021 23:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhITWAA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Sep 2021 18:00:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58356 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238137AbhITV6A (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Sep 2021 17:58:00 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7375A20117;
        Mon, 20 Sep 2021 21:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632174992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BIhkZdURvKo440WvszixxkyDOUCmdjR1uKzKiSACfvY=;
        b=m15XaQFcyZVqaBa9Nz7LKUcKNfX77iy0HQTzjOy0Tr40VdJWVcuW2Js+44RVkEKUupqJ8s
        0VC8PoFCc3erkiitgBazt7dxg5ZPWUTYPkCAY6iUHQQt9UJoVVJ5ur0z29uuH3Ufn+c8G7
        hxkPjbdC0RoP3uAQEFo9XlkMSB372lY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632174992;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BIhkZdURvKo440WvszixxkyDOUCmdjR1uKzKiSACfvY=;
        b=1QWgUSAHloGghPdWxkYUQYgfLAn8wzVImEra0fVDh+AqXsXcg5y3FAdBaik8ynEOJvHYV7
        sJNOEHvrbH1pQuBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B90013B2E;
        Mon, 20 Sep 2021 21:56:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NbHcCJADSWH+SgAAMHmgww
        (envelope-from <schwab@suse.de>); Mon, 20 Sep 2021 21:56:32 +0000
From:   Andreas Schwab <schwab@suse.de>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, broonie@kernel.org,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: Re: REGRESSION: "spi: add of_device_uevent_modalias support" and
 following "fix" breaks Macchiatobin
References: <YUhgbW8CiYI/rm+y@shell.armlinux.org.uk>
        <871r5j6nlw.fsf@igel.home> <YUjlwaRdmFMZHJYO@shell.armlinux.org.uk>
X-Yow:  ..Hmmm...This thing is really VIBRATING! ..It's getting WARM, too!
Date:   Mon, 20 Sep 2021 23:56:31 +0200
In-Reply-To: <YUjlwaRdmFMZHJYO@shell.armlinux.org.uk> (Russell King's message
        of "Mon, 20 Sep 2021 20:49:21 +0100")
Message-ID: <87wnna6hdc.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sep 20 2021, Russell King (Oracle) wrote:

> On Mon, Sep 20, 2021 at 09:41:47PM +0200, Andreas Schwab wrote:
>> On Sep 20 2021, Russell King (Oracle) wrote:
>> 
>> > Therefore, this change breaks module autoloading.
>> 
>> Reverting this change breaks module autoloading.
>
> No.
>
> Module autoloading worked before.

Nope.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
