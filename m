Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4AD4C870E
	for <lists+linux-spi@lfdr.de>; Tue,  1 Mar 2022 09:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiCAIuX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Mar 2022 03:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiCAIuW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Mar 2022 03:50:22 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5332389315
        for <linux-spi@vger.kernel.org>; Tue,  1 Mar 2022 00:49:40 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BEF423F170
        for <linux-spi@vger.kernel.org>; Tue,  1 Mar 2022 08:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646124577;
        bh=i5oNvJtWT2nQMVMnHuzSOVOeJhkbSN882hqbqowwmW8=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=c88GyFPPo6sEwnpjjs3fjMh3NHJh3kPCBNjrInIgh23e3G6SGRqawoNFlPTEhiSNv
         kMwZtbcAsIMxQnsmp/VwSYAhTq/d2UdLvP2SilIXIGcne16HbqKsqrWWJqsLxzyokQ
         jkVQWxuqQS0w+but44E/uhUYGq3cQsbVg6tz8cPD/WNQVl5JOHDpCG0YPkSogwoY77
         9iuOk7l3lLbvUxgY2Cu/vroMtp3i3nFNSWZREgrt7JsXjM3BTXUvxwQJx787KoL1/T
         VUR8tdZg2d+SWk/O4NWqHXPvozKPf0FOICkJ6N4R28PJ/4K9+UH1/l5S7KBIEW/zPi
         LxXxlJZgCkoTA==
Received: by mail-ej1-f69.google.com with SMTP id qf24-20020a1709077f1800b006ce8c140d3dso6499828ejc.18
        for <linux-spi@vger.kernel.org>; Tue, 01 Mar 2022 00:49:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i5oNvJtWT2nQMVMnHuzSOVOeJhkbSN882hqbqowwmW8=;
        b=bVKWWQFyKBqhYLL0gc5sOzubSnfd5hxKIeR1uF0HbYn7/p4SUjwcCekZeGQX9zLiUs
         a07EpBmNeQrvra+2oHIF1nK1O9rZ0A/VZUpfBQ7cTOcMmDK8Mq2wtOWaqYJc7St5jdAc
         APowL82q6K0lp2GqwHrH7ew9R0VVp3nlxVzsU0UP4cHr/vjd7rzHtRqML90oyOgrWEEe
         p8trpCOqHe5CQQe7jbY+ZDMxUqK1dKU5Ak20lNLd0WhpGQK9IbRVpBFl7WNW3RBLWGI+
         c4EL36ffHqnLsBfpKVRWl6YyBHV4Ygc52I7rYKNy3KPOK6v7rheXOzxHGxNg0H8qoqQW
         G0kg==
X-Gm-Message-State: AOAM5307SoRe1IEVPh+QYejs7h85YcAPFJv8ffzixeXbqc5sbcG5Dvc3
        0prfj+/kaWBTug6V8KLTApVJnPqtAsuprv4gft8l3vD+W82n3mJGIcsAxbXrfG1jROzdi9OqvI5
        SMkNyUabDzyQ5+7jkNKs16nwcXlcBN0gXkQ8Plw==
X-Received: by 2002:aa7:db47:0:b0:413:7649:c2bb with SMTP id n7-20020aa7db47000000b004137649c2bbmr18696628edt.123.1646124577530;
        Tue, 01 Mar 2022 00:49:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0Ji57X8BPtLBdo02/7Aw5hrJyfazNqZcwT3ns08IlVBGD/uW7vhmHoqEKLaS5kqGFV7Hlhw==
X-Received: by 2002:aa7:db47:0:b0:413:7649:c2bb with SMTP id n7-20020aa7db47000000b004137649c2bbmr18696608edt.123.1646124577357;
        Tue, 01 Mar 2022 00:49:37 -0800 (PST)
Received: from [192.168.0.136] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id y14-20020a50eb8e000000b00410a2e7798dsm6893213edr.38.2022.03.01.00.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 00:49:36 -0800 (PST)
Message-ID: <40d9b2ad-2f8a-42c8-54cf-b22e24d78538@canonical.com>
Date:   Tue, 1 Mar 2022 09:49:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 01/11] driver: platform: Add helper for safer setting
 of driver_override
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
References: <20220228200326.GA516164@bhelgaas>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220228200326.GA516164@bhelgaas>
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

On 28/02/2022 21:03, Bjorn Helgaas wrote:
> On Sun, Feb 27, 2022 at 02:52:04PM +0100, Krzysztof Kozlowski wrote:
>> Several core drivers and buses expect that driver_override is a
>> dynamically allocated memory thus later they can kfree() it.
> 
>> +int driver_set_override(struct device *dev, const char **override,
>> +			const char *s, size_t len)
>> +{
>> +	const char *new, *old;
>> +	char *cp;
>> +
>> +	if (!dev || !override || !s)
>> +		return -EINVAL;
>> +
>> +	/* We need to keep extra room for a newline */
> 
> It would help a lot to extend this comment with a hint about where the
> room for a newline is needed.  It was confusing even before, but it's
> much more so now that the check is in a completely different file than
> the "show" functions that need the space.
> 

Indeed, this needs explanation.


Best regards,
Krzysztof
