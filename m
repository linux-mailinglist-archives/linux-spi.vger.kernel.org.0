Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5714BC942
	for <lists+linux-spi@lfdr.de>; Sat, 19 Feb 2022 17:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiBSQHy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 19 Feb 2022 11:07:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiBSQHx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 19 Feb 2022 11:07:53 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB0B655A;
        Sat, 19 Feb 2022 08:07:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 187CB1F383;
        Sat, 19 Feb 2022 16:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645286851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=67vyA+/JoVwRl9ijXv5MoWJd9YvlyqCs+TE+hZgFsOo=;
        b=BbwEUhv2ho6hZ4aoxLOLOJqgRs0f50gpmvevSmGgYBUhKSsQWhriA+Ns+bh81rsyOmdc67
        l86hPS5BC7iV5vjbuv49ttk7RiK24p/QiUpzcTw7uBqdk9i4Gu78SWwA3N8i1hElGrVaks
        fTE7oTDpJwysxivmZj2w6OAGzOMIvFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645286851;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=67vyA+/JoVwRl9ijXv5MoWJd9YvlyqCs+TE+hZgFsOo=;
        b=nlYvjuP/5QEXyBSEmCpneeLSt6AQY8kFk3SQosrqFk8Uio7gFfnW22m/5mWpevvkRJ45A7
        SDN91lBcq1tVhaBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AADEA1338F;
        Sat, 19 Feb 2022 16:07:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 06TFJ8IVEWKsbAAAMHmgww
        (envelope-from <afaerber@suse.de>); Sat, 19 Feb 2022 16:07:30 +0000
Message-ID: <862fc0e3-6c76-8dea-6725-a6c45ade1ecd@suse.de>
Date:   Sat, 19 Feb 2022 17:07:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 0/6] auxdisplay: Add support for the Titanmec TM1628 7
 segment display controller
Content-Language: en-US
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
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
        linux-amlogic@lists.infradead.org
References: <4172e59f-b9d5-d87d-9dbd-a6f683a2173c@gmail.com>
 <CANiq72mi5fj07cfo6T4jPmp=EiRtE_uDeHHCqjG9h+duPrUMKg@mail.gmail.com>
 <ecdbfb3a-e214-a059-95b9-1ebf2f625295@gmail.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
In-Reply-To: <ecdbfb3a-e214-a059-95b9-1ebf2f625295@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 19.02.22 14:37, Heiner Kallweit wrote:
> On 19.02.2022 14:27, Miguel Ojeda wrote:
>> On Sat, Feb 19, 2022 at 2:13 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>
>>> This series adds support for the Titanmec TM1628 7 segment display
>>> controller. It's based on previous RFC work from Andreas Färber.
>>> The RFC version placed the driver in the LED subsystem, but this was
>>> NAK'ed by the LED maintainer. Therefore I moved the driver to
>>> /drivers/auxdisplay what seems most reasonable to me.
>>
>> Could you please link to the discussion and/or summarize the rationale
>> behind the NAK?
>>
> 
> +Pavel
> 
> I didn't find an explicit reason, but I suppose Pavel sees this driver as
> one that makes use of the LED subsystem, but doesn't belong to it.
> In the following mail he's expressing his opinion that the driver should
> be best placed under auxdisplay.
> 
> https://lore.kernel.org/linux-arm-kernel/20200226130300.GB2800@duo.ucw.cz/

And I disagreed. It does not fit with the other drivers in auxdisplay
that were operating on a much higher level.

I'd also like to point out that I did implement the map_to_7segment API,
as was suggested, as you will find in my tree - which you may have
missed, referencing only the RFC patchset and putting your authorship on
it exclusively? A move from one directory to another should not warrant
my author and SoB getting removed from the actual driver.

Given that we need to manage a buffer with bits per segment or LED
symbol, one idea that I haven't found time for yet was to implement it
as framebuffer or drm device instead. (And most Realtek platforms got
broken by removing the adjustable text base defines.)

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Ivo Totev
HRB 36809 (AG Nürnberg)
