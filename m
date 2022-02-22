Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0494BF7F2
	for <lists+linux-spi@lfdr.de>; Tue, 22 Feb 2022 13:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiBVMRR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Feb 2022 07:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiBVMRR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Feb 2022 07:17:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9A24A3DB;
        Tue, 22 Feb 2022 04:16:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 87AF321102;
        Tue, 22 Feb 2022 12:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645532210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iVdf8vg0qvzMS+2GhWg8uKMuS0wEUJUmGhQCjRnv8iA=;
        b=xN0BV/BxKJm7YJCApumTK7Jzkj0N+o/vGum7SA+cr4WsMJq0ceT7pXNDmE9p4lJMxVB5Qu
        EOyAiOGgcaypZhC6h6g5E+87vqgJ/iz6ul8L71V8Zr7t+8wzExLkQDqWHlUcsoRr7m226L
        trTgni3RUp5XzYxjOY4BfokGEGeUD1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645532210;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iVdf8vg0qvzMS+2GhWg8uKMuS0wEUJUmGhQCjRnv8iA=;
        b=jqx0APy4xTNeoCtOF2oDQRy3QyzZAdZr0+IWQToeeAn6Gb9UOL6HGy5lhJPouVobl3pcCy
        WnQNdcob+qcS88DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3842713BA0;
        Tue, 22 Feb 2022 12:16:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id c8OWDDLUFGIyOAAAMHmgww
        (envelope-from <afaerber@suse.de>); Tue, 22 Feb 2022 12:16:50 +0000
Message-ID: <f0eeb2f4-b47d-f0d8-2169-388899d1cfdf@suse.de>
Date:   Tue, 22 Feb 2022 13:16:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 5/6] auxdisplay: add support for Titanmec TM1628 7
 segment display controller
Content-Language: en-US
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
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
 <3facc242-0ce6-9170-1fee-a5ec0a66660a@gmail.com>
 <CAMuHMdUnDQKtGuN+n-t3P8e4nf9VLB+9q8fGyCh643T4Y1Knag@mail.gmail.com>
 <288225b9-85e0-0c46-5d8b-c91f76c796e5@gmail.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
In-Reply-To: <288225b9-85e0-0c46-5d8b-c91f76c796e5@gmail.com>
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

On 22.02.22 10:44, Heiner Kallweit wrote:
> On 22.02.2022 09:19, Geert Uytterhoeven wrote:
>> Hi Heiner,
>>
>> On Mon, Feb 21, 2022 at 9:26 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>> This patch adds support for the Titanmec TM1628 7 segment display
>>> controller. It's based on previous RFC work from Andreas Färber.
>>> The RFC version placed the driver in the LED subsystem, but this was
>>> NAK'ed by the LED maintainer. Therefore I moved the driver to
>>> /drivers/auxdisplay what seems most reasonable to me.
>>>
>>> Further changes to the RFC version:
>>> - Driver can be built also w/o LED class support, for displays that
>>>   don't have any symbols to be exposed as LED's.
>>> - Simplified the code and rewrote a lot of it.
>>> - Driver is now kind of a MVP, but functionality should be sufficient
>>>   for most use cases.
>>> - Use the existing 7 segment support in uapi/linux/map_to_7segment.h
>>>   as suggested by Geert Uytterhoeven.
>>>
>>> Note: There's a number of chips from other manufacturers that are
>>>       almost identical, e.g. FD628, SM1628. Only difference I saw so
>>>       far is that they partially support other display modes.
>>>       TM1628: 6x12, 7x11
>>>       SM1628C: 4x13, 5x12, 6x11, 7x10
>>>       For typical displays on devices using these chips this
>>>       difference shouldn't matter.
>>>
>>> Successfully tested on a TX3 Mini TV box that has an SM1628C and a
>>> display with 4 digits and 7 symbols.
>>>
>>> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
>>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>
>> Thanks for your patch!
>>
>>> --- /dev/null
>>> +++ b/drivers/auxdisplay/tm1628.c
>>
>>> +static int tm1628_show_text(struct tm1628 *s)
>>> +{
>>> +       static SEG7_CONVERSION_MAP(map_seg7, MAP_ASCII7SEG_ALPHANUM);
>>
>> This mapping can not be overridden by the user.  Is there any
>> specific reason you didn't make the mapping configurable from sysfs,
>> cfr. map_seg7_{show,store}() in include/uapi/linux/map_to_7segment.h?
>>
> 
> The more features an initial driver version includes, the more discussion
> topics pop up and make it less likely that we end up with at least something.
> I think there's a reason why the driver was resting since the initial
> attempt 2 yrs ago. Therefore I'd like to keep it as a MVP. 
> If somebody should have the need for add-on features, then they can be
> added later.

As I pointed out in your v1, I did implement all that already, as was
requested by Geert on my RFC:

https://github.com/afaerber/linux/commit/bbecf951348c7de8ba922c6c002a09369b717d82

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Ivo Totev
HRB 36809 (AG Nürnberg)
