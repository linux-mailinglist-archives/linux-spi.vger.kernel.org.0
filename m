Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8514126FD
	for <lists+linux-spi@lfdr.de>; Mon, 20 Sep 2021 21:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348691AbhITTpU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Sep 2021 15:45:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47538 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346772AbhITTnS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Sep 2021 15:43:18 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9E7BB21F96;
        Mon, 20 Sep 2021 19:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632166909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H1LJtJaUfqI9Tc2FxMGnPBRVeUYTMmqnm//7VHq7HlM=;
        b=HgtIwO4wRorkIH12NZExjwu4F7+C5XLFU42U9jU+nNOvd9obtVV+eKy8Ne9nwR4uPv4egX
        JS036/LR0G8mARKBpmhoGQPlgDqFbmYIIMsoxVT0VHtx4ND4vYl4WoNsdq6eKopNr5Tlwk
        IyieRb6PLn0b6y0gPnCcnRSDHadjDTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632166909;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H1LJtJaUfqI9Tc2FxMGnPBRVeUYTMmqnm//7VHq7HlM=;
        b=MXS817UIqCEnLERTA4fXziyGIytS6h9Hr74RAhna0mofI9L9L7eVcVnNy0FlGhXu+R4Wiy
        8Wo28ag5S8K8igBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56FF213AF5;
        Mon, 20 Sep 2021 19:41:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CMBvEv3jSGG5GQAAMHmgww
        (envelope-from <schwab@suse.de>); Mon, 20 Sep 2021 19:41:49 +0000
From:   Andreas Schwab <schwab@suse.de>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     broonie@kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: Re: REGRESSION: "spi: add of_device_uevent_modalias support" and
 following "fix" breaks Macchiatobin
References: <YUhgbW8CiYI/rm+y@shell.armlinux.org.uk>
X-Yow:  I want to read my new poem about pork brains and outer space...
Date:   Mon, 20 Sep 2021 21:41:47 +0200
In-Reply-To: <YUhgbW8CiYI/rm+y@shell.armlinux.org.uk> (Russell King's message
        of "Mon, 20 Sep 2021 11:20:29 +0100")
Message-ID: <871r5j6nlw.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sep 20 2021, Russell King (Oracle) wrote:

> Therefore, this change breaks module autoloading.

Reverting this change breaks module autoloading.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
