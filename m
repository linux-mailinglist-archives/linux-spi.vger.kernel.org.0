Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619764BF7FA
	for <lists+linux-spi@lfdr.de>; Tue, 22 Feb 2022 13:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiBVMTw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Feb 2022 07:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiBVMTu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Feb 2022 07:19:50 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58499AD9C;
        Tue, 22 Feb 2022 04:19:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 91C1621119;
        Tue, 22 Feb 2022 12:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645532364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q8Aq0Ckoy74UZCe6DtMgK4l1xKOMqpQJP0j1u4pDmBA=;
        b=nyEYrnboomUbw6rCwTPb7I0dekr6bEn9xChtG9zRkJR3sbUzbhVFb6D5+asxxxpZMdvzo8
        ByBGxYkf7C12/StskBQvJB2EgHYlOF8NDsGM7pqKJb9Ke9F/XCKIdWr+DHmNUJQizA8hW6
        39kbTbS2mSaJ1aN94DYWqsIDBEVVC7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645532364;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q8Aq0Ckoy74UZCe6DtMgK4l1xKOMqpQJP0j1u4pDmBA=;
        b=ncMPLE1l+dm8/do9nyZnyHtQiSxSCh69BhwyWgnVTFpHWnSlnn2IjQjLF8KEpr5KO3DJoO
        RMrYwA3l+zhiiLCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4760113C1E;
        Tue, 22 Feb 2022 12:19:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7FpJEMzUFGJsOQAAMHmgww
        (envelope-from <afaerber@suse.de>); Tue, 22 Feb 2022 12:19:24 +0000
Message-ID: <9b229724-9715-f8cd-6a2e-d7373893f021@suse.de>
Date:   Tue, 22 Feb 2022 13:19:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 0/6] auxdisplay: Add support for the Titanmec TM1628 7
 segment display controller
Content-Language: en-US
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
References: <1f39432b-84e2-e6dc-a6b8-c48ad5cf2210@gmail.com>
 <CANiq72ko6=dYBvbRc5T7Qq_2mxRtq1NpvcV_saMbTDfz0PK1aw@mail.gmail.com>
 <d8baa907-a8c8-17d3-e724-df490a0fff83@gmail.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
In-Reply-To: <d8baa907-a8c8-17d3-e724-df490a0fff83@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 21.02.22 23:57, Heiner Kallweit wrote:
> On 21.02.2022 23:10, Miguel Ojeda wrote:
>> On Mon, Feb 21, 2022 at 9:19 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>
>>> v2:
>>> - (re-)add Andreas' SoB to two patches
>>
>> But those were also developed by you too, right? i.e. it should have a
>> Co-developed-by too, otherwise it looks like you only handled the
>> patch:
>>
> 
> Right, about half of the original code was reworked. Let's see whether and
> which feedback comes for v2. If a v3 should be needed, I'll follow your
> suggestion.

The dispute is that he apparently only looked at my RFC but didn't ask
me or check himself for newer code, which there was.

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Ivo Totev
HRB 36809 (AG Nürnberg)
