Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54031495447
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jan 2022 19:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347578AbiATSjb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jan 2022 13:39:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54897 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347202AbiATSjb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Jan 2022 13:39:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642703970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y2Tr2w2KhGLaZjzwWbGdnBD9ERdi9Y6i7NykFHXA0GU=;
        b=FFopw7AhStcMuNUNKHouzmn+xuGzYfpR5vFFKt/8owYL3rb4KKiEU22qDYGQ7PQFePzl8+
        /vfEaeGWNvrnDP1ejyyhczQlOemE2w0FTGkpbyTzP6h78gQz2A0KJHwJhZbOCSD75n2N0X
        R4eE/ccN+ygKUr4Hm6L7exZ+eL69Ww8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-0RrBbMItM8ekCXpDyFeRzQ-1; Thu, 20 Jan 2022 13:39:28 -0500
X-MC-Unique: 0RrBbMItM8ekCXpDyFeRzQ-1
Received: by mail-ed1-f71.google.com with SMTP id bs4-20020a056402304400b004032af6b7ebso6703906edb.16
        for <linux-spi@vger.kernel.org>; Thu, 20 Jan 2022 10:39:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y2Tr2w2KhGLaZjzwWbGdnBD9ERdi9Y6i7NykFHXA0GU=;
        b=nUvRdll69MW8uPrDnMIvsstWCeFYKqvvFYvWTFJWU5gYTbDJMAFKVXSDfZgozpzmTX
         HaToXPj51LYjgaUSLtpRb/eBBkjKtkcZPDZk1ZUXjNKldu5O0dacImep0y+K1C+T4XmX
         cmTqKs8vuYzeq9BD3ZUKNYnkVkqlyvQ8mg6EOpBGxXBkVxEubuo5Kyxpf9m/vYEPv+UK
         qdlf1ErpXnTpboBZfet02ZfLIn6PZGzd5wNrePX1I7C+j0GzPeI6Fi5ZNqed42k35ibJ
         CjlzLAbVoIndlg92QxmCLLLiwLRVY1l3oVUZRulBr443ZrKE6AJPXxKXkuGs88LWMv/x
         a+fw==
X-Gm-Message-State: AOAM531810WjKBSwFSE2HsSRzH7OisFF773FliuniY46tCVLarrzdKXp
        I5DaPkbM7HCXxy6GuqWvYGssGBaBdy4dJdqFmnrNd3eoRz+0RlS/QP0H9a59yT4jZDUGrN/4e7j
        HMDgqj4CxNAZpzDcpUn3W
X-Received: by 2002:a05:6402:1855:: with SMTP id v21mr419091edy.328.1642703967838;
        Thu, 20 Jan 2022 10:39:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfZxreaov7LMsQlBiYl+OTguKs/iaak+cSZJpL1mSTLbNg3ad9XAhJtXWD4vipGEMND/YNtQ==
X-Received: by 2002:a05:6402:1855:: with SMTP id v21mr419077edy.328.1642703967706;
        Thu, 20 Jan 2022 10:39:27 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id a26sm1294715ejr.213.2022.01.20.10.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 10:39:26 -0800 (PST)
Message-ID: <c75198ce-8d59-d81c-8355-8beca7bc8136@redhat.com>
Date:   Thu, 20 Jan 2022 19:39:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v4 5/9] platform/x86: i2c-multi-instantiate: Rename it for
 a generic bus driver name
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        patches@opensource.cirrus.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>
References: <20220120134326.5295-1-sbinding@opensource.cirrus.com>
 <20220120134326.5295-6-sbinding@opensource.cirrus.com>
 <CAJZ5v0hMdfnu5PUk3sPvzF_f+xvWaRkE=BUpSAFx_DJ9sB+JDw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0hMdfnu5PUk3sPvzF_f+xvWaRkE=BUpSAFx_DJ9sB+JDw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 1/20/22 19:34, Rafael J. Wysocki wrote:
> On Thu, Jan 20, 2022 at 2:43 PM Stefan Binding
> <sbinding@opensource.cirrus.com> wrote:
>>
>> From: Lucas Tanure <tanureal@opensource.cirrus.com>
>>
>> Rename I2C multi instantiate driver to bus-multi-instantiate for
>> upcoming addition of SPI support
> 
> TBH, I don't particularly like the new naming.
> 
> Namely, the "bus" part seems overly generic (and the "bmi"
> abbreviation brings something totally different to mind).
> 
> AFAICS this can cover serial interfaces only and specifically the ones
> where serial links can be represented as resources returned by the
> ACPI _CRS object.
> 
> I would call it serial-multi-instance or similar.

serial-multi-instantiate works for me. That also nice matches
up with the ACPI_RESOURCE_TYPE_SERIAL_BUS which acpi/scan.c
uses to detect these kinda resources.

Regards,

Hans



