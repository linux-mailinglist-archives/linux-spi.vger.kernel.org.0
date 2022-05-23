Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC815312A1
	for <lists+linux-spi@lfdr.de>; Mon, 23 May 2022 18:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiEWOLV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 May 2022 10:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbiEWOLK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 23 May 2022 10:11:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A1381F61B
        for <linux-spi@vger.kernel.org>; Mon, 23 May 2022 07:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653315066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cQ2F3mi+DuL7lUq4YcbWoe7vDTV3N7hMeos9Mv7PPDg=;
        b=XPDZtxYzZbcjA4r2a4LRRrAEHvLNrAQASfWrTG11oZmi1fNVqmhDGvmIWbthEwN0PmtBpJ
        mSWZchpuAmKguArYKBnPFLsQDWUb+kMIXrNc7U1r+CkB+UTtfvBuDK6wyqKqyy4edMrxEW
        +EfzR33hddUJ8QB9MKxpB56D2+DR63Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-m291fdrjNySBGUQQ0dccqQ-1; Mon, 23 May 2022 10:11:04 -0400
X-MC-Unique: m291fdrjNySBGUQQ0dccqQ-1
Received: by mail-wm1-f72.google.com with SMTP id p21-20020a05600c359500b0039740f3d32dso3940830wmq.9
        for <linux-spi@vger.kernel.org>; Mon, 23 May 2022 07:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cQ2F3mi+DuL7lUq4YcbWoe7vDTV3N7hMeos9Mv7PPDg=;
        b=eWMQfjhfrbfeF1qH8Wd5thKI6LqkxXFUCRp+kck7HtYGmwj/qJP858Rk0mPczmgXYx
         +yPGOXV8ar9TdUETy3Ic53NTsLo4yF6M9EFL1YdWYmqsaJz8CgDTAzqYQ6TMAKwHzGWG
         1ldJQhLo1bFt8qieTlquKdkswOAqz7LmQIWLGW5ilJZ1bINRxvOGxPnnVfAoh58bAPsJ
         y31fjP+4uBxoliGt3Uxt+Mn/JcMAGOyCDjLD+V6Oy41exEYwdL5QT0GBhV7TWyIAIDOH
         mVSmc/qQU1nWRdScxeWd0PMRTxXNnEeHIhOhpsLe3JLN35jXAS/8bpr3whhAVRc5a1OO
         b95w==
X-Gm-Message-State: AOAM5327eboYPfKu6R2xv2ihmI++7iffzHsFk1yxVC4hjR6kSoG14Ngs
        RrCOZKj2PXeTfhBcUbmLcVlJ4E8aMDwZ4TdYoJQPDj5Lm4Z4rpKoufs2NQf9glxDL6ulU3t9Fg8
        A5HX4k2p5OIlkKCUiz0c7
X-Received: by 2002:a05:6000:1a45:b0:20e:6164:d86c with SMTP id t5-20020a0560001a4500b0020e6164d86cmr18845482wry.561.1653315063179;
        Mon, 23 May 2022 07:11:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymLcijc3WiiGUvKg1xxfLQz9gs2q9wfB9ZCIjGILyrJP57aIq3qOAI307PMuGJbT3BHnIfYw==
X-Received: by 2002:a05:6000:1a45:b0:20e:6164:d86c with SMTP id t5-20020a0560001a4500b0020e6164d86cmr18845462wry.561.1653315062962;
        Mon, 23 May 2022 07:11:02 -0700 (PDT)
Received: from [172.20.10.7] ([90.167.95.5])
        by smtp.gmail.com with ESMTPSA id l15-20020adfbd8f000000b0020e65d7d36asm10459492wrh.11.2022.05.23.07.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 07:11:02 -0700 (PDT)
Message-ID: <0389b672-a4f4-4943-7b3e-7732685ae6c2@redhat.com>
Date:   Mon, 23 May 2022 16:11:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] drm/st7735r: Fix module autoloading for Okaya RH128128T
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        David Lechner <david@lechnology.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
References: <20220520091602.179078-1-javierm@redhat.com>
 <CAMuHMdVmFGjGbHz1yo7tOzqtUbMTDkUxaMo2fVSp1HMU=_1emA@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdVmFGjGbHz1yo7tOzqtUbMTDkUxaMo2fVSp1HMU=_1emA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=javierm@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Geert,

On 5/20/22 14:02, Geert Uytterhoeven wrote:
> Hi Javier,
> 
> CC spi
> 
> On Fri, May 20, 2022 at 11:16 AM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> The SPI core always reports a "MODALIAS=spi:<foo>", even if the device was
>> registered via OF. This means that the st7735r.ko module won't autoload if
>> a DT has a node with a compatible "okaya,rh128128t" string.
>>
>> In that case, kmod expects a "MODALIAS=of:N*T*Cokaya,rh128128t" uevent but
>> instead will get a "MODALIAS=spi:rh128128t", which is not present in the
>> list of aliases:
>>
>>   $ modinfo drivers/gpu/drm/tiny/st7735r.ko | grep alias
>>   alias:          of:N*T*Cokaya,rh128128tC*
>>   alias:          of:N*T*Cokaya,rh128128t
>>   alias:          of:N*T*Cjianda,jd-t18003-t01C*
>>   alias:          of:N*T*Cjianda,jd-t18003-t01
>>   alias:          spi:jd-t18003-t01
>>
>> To workaround this issue, add in the SPI table an entry for that device.
>>
>> Fixes: d1d511d516f7 ("drm: tiny: st7735r: Add support for Okaya RH128128T")
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Thanks for your patch!
> We really need to fix this at the subsystem level.
> 

Yes, agreed.

> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>

Thanks! I've pushed this to drm-misc (drm-misc-next) with your Reviewed-by
and David's Acked-by.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

