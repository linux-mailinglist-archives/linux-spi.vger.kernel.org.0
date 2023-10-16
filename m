Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763287CAD9B
	for <lists+linux-spi@lfdr.de>; Mon, 16 Oct 2023 17:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjJPPfC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Oct 2023 11:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjJPPfB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Oct 2023 11:35:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3542683
        for <linux-spi@vger.kernel.org>; Mon, 16 Oct 2023 08:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697470460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RPRhpPC18KaMGaT72RRJQ/JKOBjEh62LPYtBWm6lGZQ=;
        b=hRcucPDnY+BF1YyNlIauD47Ax+4PXUwk1Lwb+wkGEJfKVrEEjuCeYAOub6lRgpKu8XT9w0
        864D3EJRJXAEggE4UHOhiy+p1twC8WlFytB9IuPd/iRKUx/F7jJQ7n/sh06FcVFdjJtrFa
        vsZh4q2A64u/lV3/+kObUUpL/8l22RM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-HhUA27XuM_yvVP97wpEtNQ-1; Mon, 16 Oct 2023 11:34:13 -0400
X-MC-Unique: HhUA27XuM_yvVP97wpEtNQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99c8bbc902eso352324666b.1
        for <linux-spi@vger.kernel.org>; Mon, 16 Oct 2023 08:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697470452; x=1698075252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPRhpPC18KaMGaT72RRJQ/JKOBjEh62LPYtBWm6lGZQ=;
        b=HnNpaFc+wTQ4RcPCixkcD0bfsKhWBGJYNFRfxzj/xgmXaCy0cGHVrZ2fARiZJ2MuoR
         MReYlCo8GPeermttBa+D+7zzI4T60W4dTSkeJwU/MdFcpmNNaIPpq5t8Sg/ql/1/4ZfZ
         mtlfHXZLHm8MhqNdd0IqzLiA99WapIo8s8C2cnNacmmZFD0sKidoHD69R0IbEy+87qre
         fIbRWIXUOZgC5U70RaZG+oyQabdXb6+3UzY7vjvGbg9S1jgalpuHP6MjvAxrDmJy3mSc
         dUhxLF9pSy4Pq/CS3fnIYlh8hK5khExZOViS2+okpg6zfE89bfzTBemc2RC/tke4w7+n
         LO+Q==
X-Gm-Message-State: AOJu0YycxkWbElVgw4PkTnd1zBYZkKKpx+p+xn162KWqNhFmIKMX4j0k
        n5Po+6lpuInXXFTSE3rl7S4b/Tfior0NqaQuqSO2k37rxGk6ihK1FflscVhPTH0v71IcD3JeQPN
        NsNeDBRB7h7ObqrGz4he6
X-Received: by 2002:a17:906:7949:b0:9bd:ff07:a58a with SMTP id l9-20020a170906794900b009bdff07a58amr7765772ejo.53.1697470452098;
        Mon, 16 Oct 2023 08:34:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7c5VXHjpz6kDDov4qHMw6C/Oj6MjxdvABy2uuy5M+drjyXqut4Nr8/fIvCZH9LvhdZmXptA==
X-Received: by 2002:a17:906:7949:b0:9bd:ff07:a58a with SMTP id l9-20020a170906794900b009bdff07a58amr7765756ejo.53.1697470451787;
        Mon, 16 Oct 2023 08:34:11 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id dk6-20020a170906f0c600b009c3827134e5sm2641958ejb.117.2023.10.16.08.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 08:34:11 -0700 (PDT)
Message-ID: <7d3f0ecc-bbd7-41c3-413b-c024563e2941@redhat.com>
Date:   Mon, 16 Oct 2023 17:34:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/4] platform/x86: x86-android-tablets: Add audio codec
 info for Lenovo Yoga Tab 3 Pro YT3-X90F
To:     Mark Brown <broonie@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-spi@vger.kernel.org
References: <20231014205314.59333-1-hdegoede@redhat.com>
 <20231014205314.59333-5-hdegoede@redhat.com>
 <5d777654-4700-46ad-bec2-3921d0b7d0fc@sirena.org.uk>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <5d777654-4700-46ad-bec2-3921d0b7d0fc@sirena.org.uk>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 10/16/23 16:47, Mark Brown wrote:
> On Sat, Oct 14, 2023 at 10:53:14PM +0200, Hans de Goede wrote:
> 
>> +	.micd_force_micbias = 1,
>> +	.micd_configs = lenovo_yt3_wm5102_micd_config,
>> +	.num_micd_configs = ARRAY_SIZE(lenovo_yt3_wm5102_micd_config),
>> +        .micbias={
>> +           [0]={ /*MICBIAS1*/
>> +                 .mV =2800 ,
>> +                 .ext_cap=1,
> 
> The indentation of this section seems weird - .micbias is indented and
> the lack of spaces around =s is odd.  There's also an extra space before
> the , consistently on the mV lines.

Right this is a copy and paste fail on my side, I've fixed this up
locally already, so this will be fixed in the next version.

Regards,

Hans


