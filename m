Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480F64C86C6
	for <lists+linux-spi@lfdr.de>; Tue,  1 Mar 2022 09:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbiCAIm4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Mar 2022 03:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbiCAImz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Mar 2022 03:42:55 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012BD88B0D
        for <linux-spi@vger.kernel.org>; Tue,  1 Mar 2022 00:42:13 -0800 (PST)
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D10B84092C
        for <linux-spi@vger.kernel.org>; Tue,  1 Mar 2022 08:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646124131;
        bh=dZm4dVdpcvNRhKnzE3iapZ6aqr4LkpURHZ0F0cP2Ffk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=TLNHlmxrUBpyKtMZlieR6+TUF85CJeSxMBCpowUxzlAksivCxkUvOqUEijHPC6ZTC
         wsrSsWayqArQJuZe9PmD1juWFliS4CFGfeoErfCbyjsVsHEGRbk8HZTGmeK9eKdVws
         Q8BmuI+hGwVZNA1C194YSq2L8W3U0ipASTunqm7rCiS/c3ccTgkjt8mZhqqb7SBKCx
         uiIo1OTYIy26gmc5rP6dnanI8huvQAoXMxR96hmDwRmGV41wrItfJEHEG1rEuUdM00
         8gAKekp/oghkVtdcUgf/SEQ2/H59lBO0OUSDMT1++AZit8HNXzrxK3hDtrrPjOGDRx
         6QuG2/3UemQQg==
Received: by mail-lj1-f199.google.com with SMTP id bd5-20020a05651c168500b002467c7cdfb2so4210844ljb.16
        for <linux-spi@vger.kernel.org>; Tue, 01 Mar 2022 00:42:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dZm4dVdpcvNRhKnzE3iapZ6aqr4LkpURHZ0F0cP2Ffk=;
        b=blhE5HDxsIkplmMIx4fpoD27MA/SgKbBcBFfJSwHqMzGkafd1Ir3HP4nQBTDXXPhfQ
         UFzZNUnsQbHwkxDitVwa8ryQZgYDzczI6LGyxZciZoplOUJ3iYxAV+ImHBdKsn0moERg
         3dpy7hkwYdq64qW+gqwWd1ZkVW97sWNlpPIC5Q8A58GQbgaOzk3UHvlNnClZfuBqwh9t
         I1HwrlYugXle/gl2FTFT6bdM+3Ch+Qj5PbP+cJ6k1DGCAVmr3+9qU+YFfv2F6DYBspVs
         9eLHVEgRgH4iWt3i/TtaPQsjNigOsn9FEkagFyAd1kTGFU+p9grlzHELYrdBJplc0pWm
         L/0A==
X-Gm-Message-State: AOAM530cnkt3mRbTWxO7j3KgXUQeGlnANxJbpzxTtPCEuunr2dsBY8Ot
        dvXxtovVOMpOy0wc1EJp5hw8clDSjO+DIeW3KIeUbFajdIILmbwZKTURxErm/JNBmSlPGOdHiGy
        6RvL4r/V7cN4Jky+gjgcb88sMN5P0Y0G7+uWnRQ==
X-Received: by 2002:a17:907:248a:b0:69b:ba2d:62cd with SMTP id zg10-20020a170907248a00b0069bba2d62cdmr18284933ejb.212.1646124119343;
        Tue, 01 Mar 2022 00:41:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxkLsXZPJFLzXPV5FGYgxl+qkbahIyWcZp4Gh4Ixdg/+bf55XzGLZMALWtwePubTl5fD9ILsg==
X-Received: by 2002:a17:907:248a:b0:69b:ba2d:62cd with SMTP id zg10-20020a170907248a00b0069bba2d62cdmr18284886ejb.212.1646124119100;
        Tue, 01 Mar 2022 00:41:59 -0800 (PST)
Received: from [192.168.0.135] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id bo14-20020a170906d04e00b006ce98d9c3e3sm5116757ejb.194.2022.03.01.00.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 00:41:58 -0800 (PST)
Message-ID: <59ba1fd5-4be5-278f-47df-d26c341da73a@canonical.com>
Date:   Tue, 1 Mar 2022 09:41:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 05/11] PCI: Use driver_set_override() instead of
 open-coding
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20220228200606.GA516338@bhelgaas>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220228200606.GA516338@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 28/02/2022 21:06, Bjorn Helgaas wrote:
> On Sun, Feb 27, 2022 at 02:52:08PM +0100, Krzysztof Kozlowski wrote:
>> Use a helper for seting driver_override to reduce amount of duplicated
>> code. Make the driver_override field const char, because it is not
>> modified by the core and it matches other subsystems.
> 
> s/seting/setting/
> or even better, s/for seting/to set/
> 
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
>> -	char		*driver_override; /* Driver name to force a match */
>> +	/*
>> +	 * Driver name to force a match.
>> +	 * Do not set directly, because core frees it.
>> +	 * Use driver_set_override() to set or clear it.
> 
> Wrap this comment to fill 78 columns or so.

Thanks, I'll fix both.


Best regards,
Krzysztof
