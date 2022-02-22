Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B764BFCA1
	for <lists+linux-spi@lfdr.de>; Tue, 22 Feb 2022 16:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbiBVPbw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Feb 2022 10:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiBVPbw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Feb 2022 10:31:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4413D163053;
        Tue, 22 Feb 2022 07:31:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E8E261F3A3;
        Tue, 22 Feb 2022 15:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645543884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDPR/RXvsCjUbyhuXvYy8h8gwyiPv74HOWucNF3wYxk=;
        b=lIS/6beohKMQq+8gS6SQYcDHOi/ruXQaNMzRNoW3jHVhGZc+JZqJvuFFu6bq/4qAuJtIPC
        h47tif6zGyKNdSGDQNdmvctntW3su9UxqbflWCLMN4A4mGO/UYmiMfB+FDz2Z5CVx1EHo2
        MQ37RTB+gL/CONYWVUhtMkZuqMrIbjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645543884;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDPR/RXvsCjUbyhuXvYy8h8gwyiPv74HOWucNF3wYxk=;
        b=ugoYPahRmWnja57J9+RNhmgpFpPRC15aLeQzJRi79k+bbxIb7tI2exn4EmcoUmH1SHy3FV
        5e2o0hwpoQcXzCAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C03D13BC3;
        Tue, 22 Feb 2022 15:31:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sLXXH8wBFWLrJAAAMHmgww
        (envelope-from <afaerber@suse.de>); Tue, 22 Feb 2022 15:31:24 +0000
Message-ID: <587391d0-f364-b2b6-399d-8994f4a17385@suse.de>
Date:   Tue, 22 Feb 2022 16:31:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/6] auxdisplay: Add support for the Titanmec TM1628 7
 segment display controller
Content-Language: en-US
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
References: <4172e59f-b9d5-d87d-9dbd-a6f683a2173c@gmail.com>
 <CANiq72mi5fj07cfo6T4jPmp=EiRtE_uDeHHCqjG9h+duPrUMKg@mail.gmail.com>
 <ecdbfb3a-e214-a059-95b9-1ebf2f625295@gmail.com>
 <862fc0e3-6c76-8dea-6725-a6c45ade1ecd@suse.de>
 <09bf3d8a-2902-723b-80d2-0c4d1c24f53d@gmail.com>
 <a890337b-39e4-f796-2d53-05edd2d69c80@suse.de>
 <1530c337-22b5-b20d-27ae-50696344e80f@baylibre.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
In-Reply-To: <1530c337-22b5-b20d-27ae-50696344e80f@baylibre.com>
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

On 22.02.22 15:48, Neil Armstrong wrote:
> On 22/02/2022 13:12, Andreas Färber wrote:
>> On 19.02.22 18:16, Heiner Kallweit wrote:
>>> On 19.02.2022 17:07, Andreas Färber wrote:
>>>> [...] (And most Realtek platforms got
>>>> broken by removing the adjustable text base defines.)
>>>>
>>> I'm not aware of the Realtek platform issue, do you have a link to a
>>> related discussion?
>>
>> Realtek has a boot ROM at the beginning of memory space, which has been
>> a problem from the first RFC and for most bootloaders required to tweak
>> the kernel's text offset for successful boot. (Some not Open Source (LK)
>> and/or not openly flashable.)
>>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-February/487718.html
>>
>>
>> In 2020 that arm64 feature got removed without any further discussion:
>>
>> https://lore.kernel.org/all/20200825135440.11288-1-ardb@kernel.org/
> 
> Note the TEXT_OFFSET is only an issue with Amlogic vendor bootloader,
> it has never been an issue with mainline U-Boot.

There is no mainline U-Boot for Realtek DHC (!= Amlogic Meson) though!

More important drivers than LED got blocked here, too, like MMC and USB
and pinctrl and clk.

And as hinted above, some Realtek boards come with a vendor LK that I
can't even patch a downstream version of.

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Ivo Totev
HRB 36809 (AG Nürnberg)
