Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0E54A76AD
	for <lists+linux-spi@lfdr.de>; Wed,  2 Feb 2022 18:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346216AbiBBRTN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Feb 2022 12:19:13 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:32818 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346211AbiBBRTK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Feb 2022 12:19:10 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BAB221F383;
        Wed,  2 Feb 2022 17:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643822348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yhs5rZhEYqEphWZh9zWObr/CUeKVCj/NTAl2ouVwLcY=;
        b=Tz8m3cEtQOQEuTp+cfj68lDGQ7tMzcE2ubSDwMHZftgXMk8pNrzkOgVZ/FYwHRUzo/jSw6
        dhYEzmUx7IzhHgQCWvM4PPA4/khSDhjoMV4o5UAfZnKSTFHam4ghRsRnaXlLDXyfsS1LvH
        WUMS0ecz9UFaTEledZGA1ryPmQPEfPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643822348;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yhs5rZhEYqEphWZh9zWObr/CUeKVCj/NTAl2ouVwLcY=;
        b=kkRG+jmE564hRemoHRUTMUa0Omm+eTHGCoBvBOq59xkuRME0rFlsRXzgeZYfLN8IWO8ESH
        Gny6vHyC0QXJrLCg==
Received: from alsa1.suse.de (alsa1.suse.de [10.160.4.42])
        by relay2.suse.de (Postfix) with ESMTP id 79979A3B8F;
        Wed,  2 Feb 2022 17:19:08 +0000 (UTC)
Date:   Wed, 02 Feb 2022 18:19:08 +0100
Message-ID: <s5h35l1yynn.wl-tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@opensource.cirrus.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: Re: [PATCH v6 8/9] ALSA: hda/realtek: Add support for HP Laptops
In-Reply-To: <ba39ac5f-a6b5-8b73-2e51-882cbd96a726@redhat.com>
References: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
        <20220121172431.6876-9-sbinding@opensource.cirrus.com>
        <s5hv8xxzlir.wl-tiwai@suse.de>
        <ba39ac5f-a6b5-8b73-2e51-882cbd96a726@redhat.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 Emacs/25.3
 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 02 Feb 2022 17:58:20 +0100,
Hans de Goede wrote:
> 
> Hi,
> 
> On 2/2/22 10:05, Takashi Iwai wrote:
> > On Fri, 21 Jan 2022 18:24:30 +0100,
> > Stefan Binding wrote:
> >>
> >> From: Lucas Tanure <tanureal@opensource.cirrus.com>
> >>
> >> Add support for two and four CS35L41 using the component
> >> binding method
> >>
> >> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> >> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> > 
> > Reviewed-by: Takashi Iwai <tiwai@suse.de>
> > 
> > Hans, feel free to include this one into your tree.
> 
> Ok, I'm working on merging the entire series (on top of Mark's
> spi-acpi-helpers tag) now. I'll send you a pull-req for
> a signed tag when I'm done, in case you want to merge 
> this to avoid conflicts.

Great, thanks.


Takashi
