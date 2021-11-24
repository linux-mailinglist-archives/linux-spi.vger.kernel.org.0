Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE60A45B555
	for <lists+linux-spi@lfdr.de>; Wed, 24 Nov 2021 08:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhKXHbK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Nov 2021 02:31:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54608 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233492AbhKXHbJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Nov 2021 02:31:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637738879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7OMKb/dKyQjD+7Ebuijop8gviQ0xaO52iurY6HFF7Ms=;
        b=iO1+v94mNylZmgixiiLOgVtReL0FM/QM7jlI+jNAojIazL5Y49gRRmHQaV9ZzQ/8EpvTtT
        YSSVp/XM2ZO9LCT/oOQ1Cqtt1vK0hGsgxJN/G1e/xEDH5BZTiywl5kfNmXGvRaiUzP+QJu
        aoYNBZqd3YagolwL77E/TTAt3ImyXu4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-5DDiJCfiM0qbWHiOJudlOA-1; Wed, 24 Nov 2021 02:27:58 -0500
X-MC-Unique: 5DDiJCfiM0qbWHiOJudlOA-1
Received: by mail-wr1-f69.google.com with SMTP id q5-20020a5d5745000000b00178abb72486so222497wrw.9
        for <linux-spi@vger.kernel.org>; Tue, 23 Nov 2021 23:27:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7OMKb/dKyQjD+7Ebuijop8gviQ0xaO52iurY6HFF7Ms=;
        b=at0xaZGZ1sUMbeQRvmKpvvrSounrTKWVP62th2fFDm/hM7GdvEBt93zOXc3LVnDoNT
         qS9Y6HDO9NPCTNPHxCqnuzpsl4Jb1We+LazC9dygaApYKZV+O6mTmlSaCJN8fmCXG7Jo
         tNQBOfl1V67YRXmBedyNSgEUJPM3bYNhhn8ohudijxfovNE2wb29N3ljkkD5QliGDE+h
         ALuiVFUiRXhC+G8otdCLfNJXiGrzwlkud289/wI83RICI4GbX1zF9mXl5g03lTTlpnfe
         Ul+ulehzCkuaoM4A6tuZrzRsrF+HICCZg4Dmdi0RfhQ+JI1IXD4VKVkj8jKUHJYvpkpf
         522g==
X-Gm-Message-State: AOAM532HMqbHK+E3zJFH/GxYy+g/aQUoLz93XuaSYGYKLrIN9Lbl+eRy
        yzp/laYcfA+i0y4Pw+AcdSfBmsuIfsl+gFQ8CApRWk3G+1BEBGsnzhZGkBq5/CcyCwt/qHdfzxm
        yFeufOQf3aGC1RBEQ8a5h
X-Received: by 2002:a05:600c:896:: with SMTP id l22mr12220763wmp.127.1637738876726;
        Tue, 23 Nov 2021 23:27:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKOF81PKuYHScyvKNeh2HR3n1yW8CNky/HtkVkC3Rw5qTxlFr0FyufIKB0etRC53vcTyWsTw==
X-Received: by 2002:a05:600c:896:: with SMTP id l22mr12220733wmp.127.1637738876497;
        Tue, 23 Nov 2021 23:27:56 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t17sm446705wmq.15.2021.11.23.23.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 23:27:56 -0800 (PST)
Message-ID: <10d86e45-67fa-a361-db74-468c1cc686fb@redhat.com>
Date:   Wed, 24 Nov 2021 08:27:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] spidev: Make probe to fail early if a spidev compatible
 is used
To:     Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-spi@vger.kernel.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org
References: <20211109225920.1158920-1-javierm@redhat.com>
 <20211110074247.g7eaq2z27bwdt4m5@pengutronix.de>
 <YZaZpx7cudaAEGIP@sirena.org.uk>
 <20211119074015.kji2hzarevxgfl5l@pengutronix.de>
 <9b41eb05-a095-39af-8b76-a73fa2532e92@redhat.com>
 <YZ0A6rrpDlN6e5Vh@sirena.org.uk>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YZ0A6rrpDlN6e5Vh@sirena.org.uk>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=javierm@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Mark,

On 11/23/21 15:55, Mark Brown wrote:
> On Fri, Nov 19, 2021 at 09:32:32AM +0100, Javier Martinez Canillas wrote:
>> On 11/19/21 08:40, Uwe Kleine-König wrote:
> 
>>> Not this affects also devices that use
> 
>>> 	compatible = "myvender,devicename", "spidev";
> 
>> This is indeed a corner case and I'm less sure what the kernel should do
>> about it. I just learned now that of_device_is_compatible() return value
> 
> TBH I feel like that falls into the same bucket as any other uses of
> spidev so I'm not overly worried.  Grepping around it looks like we have
> no examples of this in tree, only a few plain spidevs in DTs for older
> platforms that were most likely converted from board files and *probably*
> aren't too relevant at this point.
>

Agreed.
 
>> Or just consider DT nodes with a general "spidev" compatible string to
>> also not be valid. I would lean towards this one I think.
> 
> Yes, I think so.  Your other options are worth exploring if it turns out
> to be an issue but hopefully it's not.
>

I think that's a good plan.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

