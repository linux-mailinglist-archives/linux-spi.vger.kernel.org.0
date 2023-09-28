Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3687B1C19
	for <lists+linux-spi@lfdr.de>; Thu, 28 Sep 2023 14:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjI1MVE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Sep 2023 08:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjI1MVD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Sep 2023 08:21:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22A51A3
        for <linux-spi@vger.kernel.org>; Thu, 28 Sep 2023 05:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695903612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l3smEwL+UI6+Q/2dCb7QvgQWyJ40TpMV2o0vHCJMrgA=;
        b=Zz3nETlfgiI9GRD1x2OWOj/yaI0Tip+4D3K4hg8RQ6mwDbdk38sWcyrnFlq6qkBIArwmxd
        e9mKDCtQYhu4DmR7om+qd0bvRpjd4Hoa+jSr9KDI4m3CzTvClfeBw6XzVsJR9ee5CEOpEF
        i7GZVbuXuqySz2D9niRiYICawB/AmyE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-lnWsmMuVMFyRcT2XbX7zCg-1; Thu, 28 Sep 2023 08:20:09 -0400
X-MC-Unique: lnWsmMuVMFyRcT2XbX7zCg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5346626c1c5so4412803a12.1
        for <linux-spi@vger.kernel.org>; Thu, 28 Sep 2023 05:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695903608; x=1696508408;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3smEwL+UI6+Q/2dCb7QvgQWyJ40TpMV2o0vHCJMrgA=;
        b=JceEZgKmOGtsGZC3LP/7pSXJvL6Yp7v2gE+GpyjuhelILdJIj5vorPnThbT/KX9IqH
         Td3AJO9+4mJ0jm3F+n8CsaBxha+eAlkU/kG3EHREvpOt2N5PhjtMeEqmZUc0vyQD6kC2
         dW+uZDLJwkq/Mc99ftBgCIsnE4UBh7UgEJtSCpbKfid7NR6qc1zATT3VK88+XCUycEd7
         rS9N8P7e46XtDudjjB+iKgrrcYB7esNANPEbz+NafAC9jE40js9zv8C6vZ77whQzDzhx
         hS5kQgDgOrEOa+dEV5lO5JEMmJ7uo926A0LBU3H3GyDUUNvPC4+Yp0dORdM62VRR0ffl
         LflQ==
X-Gm-Message-State: AOJu0YzakUyNoPHf0dAOqJ6caN/FvRLsr87FqQNExWlQB2A+nklW+voC
        8hFxqfwdL8aoHjSqrz6dfTVbo25EFpXznhtROeynYOv1VEmqhxpFHbGeYbGtOcqixPwfJ3eXSbV
        /kfl5mrQNwx1cmLWoogdg
X-Received: by 2002:a05:6402:164a:b0:52f:a44e:601d with SMTP id s10-20020a056402164a00b0052fa44e601dmr1096059edx.9.1695903608315;
        Thu, 28 Sep 2023 05:20:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyO5ErgFLWf8MDBzpoDNHA/Wzf+KuJdstEciFIl3FORrSyJ3myzBVY3wU2I8qm2ccDL23Nsw==
X-Received: by 2002:a05:6402:164a:b0:52f:a44e:601d with SMTP id s10-20020a056402164a00b0052fa44e601dmr1096041edx.9.1695903608017;
        Thu, 28 Sep 2023 05:20:08 -0700 (PDT)
Received: from [192.168.1.217] ([109.36.138.103])
        by smtp.gmail.com with ESMTPSA id x18-20020aa7d6d2000000b0052febc781bfsm9608018edr.36.2023.09.28.05.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 05:20:07 -0700 (PDT)
Message-ID: <1e7c1c28-5bbe-49b5-f5ff-8cc84039f34f@redhat.com>
Date:   Thu, 28 Sep 2023 14:20:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v19 0/4] Add Intel LJCA device driver
To:     Oliver Neukum <oneukum@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Wentong Wu <wentong.wu@intel.com>
Cc:     arnd@arndb.de, mka@chromium.org, lee@kernel.org, wsa@kernel.org,
        kfting@nuvoton.com, broonie@kernel.org, linus.walleij@linaro.org,
        maz@kernel.org, brgl@bgdev.pl, linux-usb@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-gpio@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        heikki.krogerus@linux.intel.com, andi.shyti@linux.intel.com,
        sakari.ailus@linux.intel.com, bartosz.golaszewski@linaro.org,
        srinivas.pandruvada@intel.com, zhifeng.wang@intel.com
References: <1694890416-14409-1-git-send-email-wentong.wu@intel.com>
 <2023091704-nape-coconut-af6c@gregkh>
 <f576c346-db6c-dded-1502-c87d5e58fa39@redhat.com>
 <95ce1e2f-eb60-46fc-bced-06b8a150cbfb@suse.com>
In-Reply-To: <95ce1e2f-eb60-46fc-bced-06b8a150cbfb@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 9/28/23 12:18, Oliver Neukum wrote:
> On 17.09.23 13:26, Hans de Goede wrote:
>  
>> Note I did not ask for a new version to be send right away, but
>> I'm afraid there has been a bit of miscommunication and instead
>> of rebasing the next version based on further review Wentong has
>> send out a new rebased version immediately, sorry about that.
> 
> Hi,
> 
> what to do now? It's been ten days.
> I am sure this driver has been very thoroughly reviewed by now.
> We are dragging this out. Do we want the developer to do another release
> or do we ask Greg to take it as is?
> This is becoming almost comical, but that is not what we want driver
> submission to be.
> 
> As far as I am concerned on the USB side everything is fine now.
> Hans? Greg?

Note I have been mostly involved in testing these patches I have
*not* thoroughly reviewed them. I have taken a quick(ish) look
which did not find anything obviously wrong.

I agree that at least patch 1/4 is ready for merging. I'm
not sure if Greg should pick-up the entire series or if
the rest should be merged through there relevant subsystems
to also give the relevant subsys maintainer tree.

For the series:

Acked-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

