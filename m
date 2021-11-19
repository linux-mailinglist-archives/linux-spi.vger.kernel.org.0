Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57BA457623
	for <lists+linux-spi@lfdr.de>; Fri, 19 Nov 2021 19:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbhKSSEV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Nov 2021 13:04:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59943 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230405AbhKSSEU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Nov 2021 13:04:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637344878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/a6rOhLDv3JwL69Ue+qRfZwjwTKZg5m885Paq3oOLk4=;
        b=TfAtbvU4w7PYpLcw90hbuUUbOtNrzdjGsULQGseBH0aRx0DF1hAMJ8/9SDbnk96u1hmbg6
        VIC+d2yi2f10M4OFCg/saLfkm3FGn8P1GS1An708BZ1hHgyyJ4YDlfO2fMI06edxZZIy9b
        N3XwwOoRPVSRWasTdFn04tpXkW7bi+8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-goai-neQP4GNCocz87dtGg-1; Fri, 19 Nov 2021 13:01:14 -0500
X-MC-Unique: goai-neQP4GNCocz87dtGg-1
Received: by mail-wm1-f71.google.com with SMTP id 187-20020a1c02c4000000b003335872db8dso3920983wmc.2
        for <linux-spi@vger.kernel.org>; Fri, 19 Nov 2021 10:01:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/a6rOhLDv3JwL69Ue+qRfZwjwTKZg5m885Paq3oOLk4=;
        b=1ZPxCnBgdQ8oQ2UT2F/kKkh7FBzqD1I4mTwrztyxnu9lsxCkvZwEdN1wtOVChlIG1/
         89r7H/XoqeGCnqwJieTV9L5RwoXnmKzvysOvuwENSge97ozGbzBAnDw9ik2RDSMidrUJ
         JDbCvGbk8T8IHqdtm1OXYoh8J9QaA9R0QDJeRiZTC+/9rzx4yvy4z15q0apCbj53XBoC
         fzMF3U1r39Ry0Toh2RU25Rkg55t+3mesVDiw+F8VDxS1uDlkBWf0qPkDeSyxBzhxW8Uf
         qQQYbWG+DXsZVOQhe2JmDu7DMiHTTC1iVnVtlv8y6mKg1IyZntJzMsQrkxJSxP93ii1X
         1XTw==
X-Gm-Message-State: AOAM530x5N5WPlg/fKIpMDz0yskzP7KpJtQdwrAXzfrM1l8Kj3s1QVLI
        h8PRzC5F565g6Z7zlkMi+ZkqJT5a3A+lMWXeS/bvGm7ROx8iDPeuLebK8rA84qz/HybOSytwHsB
        B7ozB79OMibNNTrXl0m2J
X-Received: by 2002:adf:f54c:: with SMTP id j12mr10048570wrp.20.1637344873100;
        Fri, 19 Nov 2021 10:01:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWGJuiXfyI9qCfHWRTyH0ZcihvvNNyBX6Y4qZZ7mds6Ndbk7C5bGC/fg8jnfrzZjCYxEj+8Q==
X-Received: by 2002:adf:f54c:: with SMTP id j12mr10048513wrp.20.1637344872795;
        Fri, 19 Nov 2021 10:01:12 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l5sm332325wml.20.2021.11.19.10.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 10:01:12 -0800 (PST)
Message-ID: <e47bd075-fba1-cc34-b016-91043957c97b@redhat.com>
Date:   Fri, 19 Nov 2021 19:01:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] spi: docs: improve the SPI userspace API documentation
To:     Ralph Siemsen <ralph.siemsen@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org
References: <20211118213143.2345041-1-javierm@redhat.com>
 <20211119160325.GA1591448@maple.netwinder.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20211119160325.GA1591448@maple.netwinder.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=javierm@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Ralph,

On 11/19/21 17:03, Ralph Siemsen wrote:
> Hi Javier,
> 
> On Thu, Nov 18, 2021 at 10:31:43PM +0100, Javier Martinez Canillas 
> wrote:
>> This doc is fairly outdated and only uses legacy device instantiation
>> terminology. Let us update it and also mention the OF and ACPI device
>> tables, to make easier for users to figure out how should be defined.
> 
> Thanks for putting this together! Overall it is a definite improvement.
> 
>> +NOTE: it used to be supported to define an SPI device using the "spidev"
>> +      name.  For example as .modalias = "spidev" or compatible = "spidev".
>> +      But this is no longer supported by the Linux kernel and instead a
>> +      real SPI device name as listed in one of the tables should be used.
> 
> This note is factually correct, but it might be a little too terse for 
> folks who are not full-time kernel developers. I'd suggest making it a 
> bit more prescriptive. As well, the focus can probably be on the case of 
> device tree, since that is the one that generates the warning (and with 
> your patch, causes the driver to fail to load).
> 
> I've struggled to put it into the right words, so the following is just 
> an idea. I've intentionally included the exact wording of the warn/err 
> to improve google-ability. As well, it is interesting to do a google 

Instead of adding the messages here, I think what we should do is to point
to https://www.kernel.org/doc/Documentation/spi/spidev.rst in the spidev
driver messages.

That way we could save people a search in the interwebs. That would be a
separate patch for the spidev driver of course.

> search for the message, and see what kinds of advice is offered. A few 
> that came up for me include:
> https://community.nxp.com/t5/i-MX-Processors/spidev-spidev-listed-directly-in-DT/m-p/426381/highlight/true#M64609
> https://yurovsky.github.io/2016/10/07/spidev-linux-devices.html
> 
> Anyhow, here is a possible addition to the NOTE in your patch.
> 
> spidev listed directly in DT is not supported
> =============================================
>

Agree with including this section. But we could do it as a follow-up.
 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

