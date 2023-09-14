Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8842579FE2C
	for <lists+linux-spi@lfdr.de>; Thu, 14 Sep 2023 10:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbjINIWE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Sep 2023 04:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236166AbjINIWD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 Sep 2023 04:22:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F07C1FC2
        for <linux-spi@vger.kernel.org>; Thu, 14 Sep 2023 01:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694679671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gORgBWCz3hCk/bsvpm1Zfcrjb1Hz/L3M1pTUN8fqGWo=;
        b=FrbIcTd2PwRN+LUPdKPp17Ebta46Svgd9tlSkn314tUuOpEAOOnfLU7l5z7kJSqCLNQx64
        5YjrHttfbe+/22Hilu7HWP3w1QIm4q5zKzWVVnQpCpGNjci2GL4pjd1mR06ryR8aKBtjtk
        4G8gkBj5Z3yuTPNFMDhjQZw03uuL21o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-Kuu5SehLO-aZ-cMHgzVPuA-1; Thu, 14 Sep 2023 04:21:09 -0400
X-MC-Unique: Kuu5SehLO-aZ-cMHgzVPuA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-98e40d91fdfso56118366b.3
        for <linux-spi@vger.kernel.org>; Thu, 14 Sep 2023 01:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694679668; x=1695284468;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gORgBWCz3hCk/bsvpm1Zfcrjb1Hz/L3M1pTUN8fqGWo=;
        b=QBTz9f1pSfgtjvGnBGa0qay7QvluXJXB/KmOxoMMDdN0pEbJBBzPlpsN94uv2hqY+9
         gi4eisaLafnQoFvLKunMNznAMsHZKZ/mHxtNLhJtDP1FVL7oMZR8VzNbolK6+8+eyWjE
         VnwcuabatoqU4e0bSJxKXLcxiYmDG3EwJbXw38Whay0MKghtcumfEMJq0egmnVGWPyO5
         s/yS5FpwWKIXs2sFtMqLjL0rtgYBIiWoh6kXOgZax53LG2WtkCG63RrC+mGGO5n3RPn3
         mj1QsYWUBhR12gtKeITF2gBjUzqSuCD6vkBovJMvf9Dqoz0iXBBbtOwu5Ed5lNEiTRH6
         5ofw==
X-Gm-Message-State: AOJu0Yy+mdMxS1bMMR5C14akM0cVI2dR72UzspgD/R0nZc9Bnlah7tbZ
        Y/UtGFLbRMDcZfghlXdXxFHAzgAmFP+9IcnWVAu+S99mHS9XfKXw97WvPfiTkz1F92MKk0m3vHL
        ca2hb1Ex6yOd5STYZJXhc
X-Received: by 2002:a17:906:3297:b0:9a5:ceab:f496 with SMTP id 23-20020a170906329700b009a5ceabf496mr4081136ejw.58.1694679668723;
        Thu, 14 Sep 2023 01:21:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIHVU/Fju08DmHRKzYeSJRU9Ob1ijnlRZaI7gxrw6vRuFB2bAZhoQPlpyfvbxJKGQRPZ+NXA==
X-Received: by 2002:a17:906:3297:b0:9a5:ceab:f496 with SMTP id 23-20020a170906329700b009a5ceabf496mr4081120ejw.58.1694679668430;
        Thu, 14 Sep 2023 01:21:08 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id x5-20020a1709065ac500b00993664a9987sm647322ejs.103.2023.09.14.01.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 01:21:07 -0700 (PDT)
Message-ID: <05b9b252-653c-7cf7-9b96-59d9f662b81e@redhat.com>
Date:   Thu, 14 Sep 2023 10:21:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v16 1/4] usb: Add support for Intel LJCA device
To:     "Wu, Wentong" <wentong.wu@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "mka@chromium.org" <mka@chromium.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "kfting@nuvoton.com" <kfting@nuvoton.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "maz@kernel.org" <maz@kernel.org>, "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "andi.shyti@linux.intel.com" <andi.shyti@linux.intel.com>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "bartosz.golaszewski@linaro.org" <bartosz.golaszewski@linaro.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Wang, Zhifeng" <zhifeng.wang@intel.com>
References: <1694569212-10080-1-git-send-email-wentong.wu@intel.com>
 <1694569212-10080-2-git-send-email-wentong.wu@intel.com>
 <a3b75e11-9cf0-4ee3-be90-fba73bd5df3d@suse.com>
 <DM6PR11MB43162A9B2AC68B2686BBE2598DF7A@DM6PR11MB4316.namprd11.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <DM6PR11MB43162A9B2AC68B2686BBE2598DF7A@DM6PR11MB4316.namprd11.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 9/14/23 03:05, Wu, Wentong wrote:
>> From: Oliver Neukum <oneukum@suse.com>
>>
>> On 13.09.23 03:40, Wentong Wu wrote:
>>
>>> +struct ljca_bank_descriptor {
>>> +	u8 bank_id;
>>> +	u8 pin_num;
>>> +
>>> +	/* 1 bit for each gpio, 1 means valid */
>>> +	u32 valid_pins;
>>
>> No endianness?
> 
> On both sides, the endianness is same.

Right, but normally USB drivers are also written so that they can work on big-endian CPUs.

I realize that this driver will likely never be used with a big-endian CPU but still it is good practice to make the driver work on big-endian CPUs too. Even if it is just to set a good example when other drivers copy the code.

So this should be:

struct ljca_bank_descriptor {
	u8 bank_id;
	u8 pin_num;

	/* 1 bit for each gpio, 1 means valid */
	__le32 valid_pins;
} __packed;

And then when reading valid_pins you should use:

	u32 valid_pins = get_unaligned_le32(&ljca_bank_descriptor.valid_pins);

On x86_64 the compiler should optimize all of this away to
just a regular read.

Regards,

Hans


