Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532F1790853
	for <lists+linux-spi@lfdr.de>; Sat,  2 Sep 2023 16:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjIBO7N (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 2 Sep 2023 10:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbjIBO7L (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 2 Sep 2023 10:59:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BDB10F4
        for <linux-spi@vger.kernel.org>; Sat,  2 Sep 2023 07:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693666707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J7DnlXZk1KOF8qHNOxOS8ckGGq+BT5k7KKa2YThEEKc=;
        b=it0SmPvQn45rXyD4GEO5PqjfXG6MY+GozKBZby2XTkkwHXo7AXxhcFbg7CzxA7m9zX8rmZ
        JC+v5CgHC7PdT0PmVPoODjTYDJtzvpElkdLJATjbaialyR60Jx0V3t9Z8TpkIpqqdwcIAS
        qWAK56uTg7zeKrx6nWhncA+VAPJrLQg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-gJyEW2dANZGRVsRYKTGMlw-1; Sat, 02 Sep 2023 10:58:25 -0400
X-MC-Unique: gJyEW2dANZGRVsRYKTGMlw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9a198d4d98aso3498566b.1
        for <linux-spi@vger.kernel.org>; Sat, 02 Sep 2023 07:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693666704; x=1694271504;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZVeMbauliYYISM20IxNeM/16/K7tsybvKpmJT8N7EWQ=;
        b=J7ISCxHfvtIBrMoIQGWSxXWCGyWlOd8INKAbOYyc77pCCuYzEUObc/p4if3jWgFW8b
         N9PJw+jikf58FZ2JnLqtecjZaXlTR/FHire5GYrxvwuyDbk9Vh0Q65OMvGdVhznz93/f
         Us5XLd4YMclU56hqUyT2P/gB0FagQumLqqcjmpBKwF2VajyvNB8iJ+47wiwRZonXNV9k
         kfDxzncBODpt5eV7lk4wMV0T+M4iR6tsTuvsXk2irnL3i8qSaTR24oQPhPN5ffy+UWxD
         2lm2GTXZhKqyGXbOeGQjyydbzp5dAnEDUI+1CtpyL4PVk9k9syNYl7qbl+ICM0+ioOAA
         5Opw==
X-Gm-Message-State: AOJu0Yy+OxKeJenSe1Hsb72T44dqMQYYoZ8WI9nchM3FMF1r7YjqzUsW
        3zkD6GTcf3QXi6hKqd1KNI0ThKJTVlMGZybW5Fq5ZZxgP0WOJD+ebpjcznYfQGy+Uc7qTGmkEI0
        Xc6zo8FKPB/oFOu0AEdJ5
X-Received: by 2002:a17:906:cc12:b0:9a5:a068:553f with SMTP id ml18-20020a170906cc1200b009a5a068553fmr4064788ejb.50.1693666704237;
        Sat, 02 Sep 2023 07:58:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdk5vHDJzE7IwsoqqZLyLGYvu795ZdGGKC/ksKpLStjbO5NBBYmr9fg3ol2vHzNk9TTxqdVw==
X-Received: by 2002:a17:906:cc12:b0:9a5:a068:553f with SMTP id ml18-20020a170906cc1200b009a5a068553fmr4064772ejb.50.1693666703863;
        Sat, 02 Sep 2023 07:58:23 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a6-20020a170906244600b0099cce6f7d50sm3521549ejb.64.2023.09.02.07.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Sep 2023 07:58:23 -0700 (PDT)
Message-ID: <7fc37bb5-2121-4174-fb1d-9edf49213a6c@redhat.com>
Date:   Sat, 2 Sep 2023 16:58:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 0/4] Add Intel LJCA device driver
To:     Wentong Wu <wentong.wu@intel.com>, gregkh@linuxfoundation.org,
        arnd@arndb.de, mka@chromium.org, oneukum@suse.com, lee@kernel.org,
        wsa@kernel.org, kfting@nuvoton.com, broonie@kernel.org,
        linus.walleij@linaro.org, maz@kernel.org, brgl@bgdev.pl,
        linux-usb@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-gpio@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com,
        andi.shyti@linux.intel.com, sakari.ailus@linux.intel.com,
        bartosz.golaszewski@linaro.org, srinivas.pandruvada@intel.com
Cc:     zhifeng.wang@intel.com
References: <1693546577-17824-1-git-send-email-wentong.wu@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <1693546577-17824-1-git-send-email-wentong.wu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="------------Hu3v8sgYmgcWz7S6vFvyqoA4"
Content-Language: en-US, nl
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This is a multi-part message in MIME format.
--------------Hu3v8sgYmgcWz7S6vFvyqoA4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/1/23 07:36, Wentong Wu wrote:
> Add driver for Intel La Jolla Cove Adapter (LJCA) device. This is
> a USB-GPIO, USB-I2C and USB-SPI device. We add 4 drivers to support
> this device: a USB driver, a GPIO chip driver, a I2C controller
> driver and a SPI controller driver.

Thanks. I've been testing this on a Lenovo X1 ThinkPad Yoga gen 8
with an ov2740 sensor connected to the LJCA device.

I needed 2 small(ish) fixes to make everything work there.
I have attached the 2 fixes here.

With these 2 fixes this series is:

Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans





> ---
> v12:
>  - switch dev_err to dev_dbg for i2c-ljca driver
>  - avoid err printing because of calling usb_kill_urb when
> attempts to resubmit the rx urb
> 
> v11:
>  - switch dev_err to dev_dbg for i2c-ljca driver
>  - remove message length check because of defined quirk structure
>  - remove I2C_FUNC_SMBUS_EMUL support
> 
> v10:
>  - remove ljca_i2c_format_slave_addr
>  - remove memset before write write w_packet
>  - make ljca_i2c_stop void and print err message in case failure
>  - use dev_err_probe in ljca_i2c_probe function
> 
> v9:
>  - overhaul usb-ljca driver to make it more structured and easy understand
>  - fix memory leak issue for usb-ljca driver
>  - add spinlock to protect tx_buf and ex_buf
>  - change exported APIs for usb-ljca driver
>  - unify prefix for structures and functions for i2c-ljca driver
>  - unify prefix for structures and functions for spi-ljca driver
>  - unify prefix for structures and functions for gpio-ljca driver
>  - update gpio-ljca, i2c-ljca and spi-ljca drivers according to usb-ljca's changes
> 
> Wentong Wu (4):
>   usb: Add support for Intel LJCA device
>   i2c: Add support for Intel LJCA USB I2C driver
>   spi: Add support for Intel LJCA USB SPI driver
>   gpio: update Intel LJCA USB GPIO driver
> 
>  drivers/gpio/Kconfig          |   4 +-
>  drivers/gpio/gpio-ljca.c      | 246 +++++++------
>  drivers/i2c/busses/Kconfig    |  11 +
>  drivers/i2c/busses/Makefile   |   1 +
>  drivers/i2c/busses/i2c-ljca.c | 326 +++++++++++++++++
>  drivers/spi/Kconfig           |  11 +
>  drivers/spi/Makefile          |   1 +
>  drivers/spi/spi-ljca.c        | 297 +++++++++++++++
>  drivers/usb/misc/Kconfig      |  14 +
>  drivers/usb/misc/Makefile     |   1 +
>  drivers/usb/misc/usb-ljca.c   | 817 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/usb/ljca.h      | 113 ++++++
>  12 files changed, 1737 insertions(+), 105 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-ljca.c
>  create mode 100644 drivers/spi/spi-ljca.c
>  create mode 100644 drivers/usb/misc/usb-ljca.c
>  create mode 100644 include/linux/usb/ljca.h
> 

--------------Hu3v8sgYmgcWz7S6vFvyqoA4
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-usb-ljca-Fix-picking-the-ACPI-companion-for-the-I2C-.patch"
Content-Disposition: attachment;
 filename*0="0001-usb-ljca-Fix-picking-the-ACPI-companion-for-the-I2C-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBjNDNmNzMwMTRjNjUyYTY2MTZiMzYwZWRjMmJlNTgyMDk4OTYwMzgyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPgpE
YXRlOiBTYXQsIDIgU2VwIDIwMjMgMTI6MDg6MTYgKzAyMDAKU3ViamVjdDogW1BBVENIIDEvNF0g
dXNiOiBsamNhOiBGaXggcGlja2luZyB0aGUgQUNQSSBjb21wYW5pb24gZm9yIHRoZSBJMkMKIGNv
bnRyb2xsZXJzCgpUaGUgbGpjYSBJTy1leHBhbmRlciBoYXMgMiBJMkMgY29udHJvbGxlcnMsIHdo
aWNoIGJvdGggaGF2ZQp0aGUgc2FtZSBBUEkgSElELCBlLmcuICJJTlRDMTA5NyIgb24gYSBMZW5v
dm8gWDEgVGhpbmtQYWQgWW9nYSBnZW4gOC4KClRha2luZyB0aGUgZmlyc3QgQUNQSSBjb21wYW5p
b24gd2hpY2ggbWF0Y2hlcyB0aGUgSElEIHJlc3VsdHMgaW4gYm90aApJMkMgY29udHJvbGxlcnMg
Z2V0dGluZyBhc3NpZ25lZCB0aGUgc2FtZSBBQ1BJIGNvbXBhbmlvbi4KCkFkZCBhbiBBQ1BJIFVJ
RCBjaGVjayB0byBhc3NpZ24gdGhlIHJpZ2h0IGNvbXBhbmlvbiB0byBib3RoCkkyQyBjb250cm9s
bGVycy4gVGhpcyBmaXhlcyBubyBpMmMtY2xpZW50IGdldHRpbmcgaW5zdGFudGlhdGVkIGZvcgp0
aGUgb3YyNzQwIHNlbnNvciBvbiBhIExlbm92byBYMSBUaGlua1BhZCBZb2dhIGdlbiA4LgoKTm90
ZSBzb21lIERTRFRzIGhhdmUgb25seSAxIEFDUEkgY29tcGFuaW9uIGZvciB0aGUgMiBJMkMgY29u
dHJvbGxlcnMKYW5kIHRoZXNlIGRvbid0IHNldCBhIFVJRCBhdCBhbGwuIE9uIHRoZXNlIG1vZGVs
cyBvbmx5IHRoZSBmaXJzdCBJMkMKY29udHJvbGxlciBpcyB1c2VkLiBTbyBpZiBhIEhJRCBtYXRj
aCBoYXMgbm8gVUlEIHVzZSAiMCIgZm9yIHRoZSBISUQuCmFzc2lnbmluZyB0aGUgQUNQSSBjb21w
YW5pb24gdG8gdGhlIGZpcnN0IEkyQyBjb250cm9sbGVyLgpBbiBleGFtcGxlIGRldmljZSB3aXRo
IHRoaXMgc2V0dXAgaXMgdGhlIERlbGwgTGF0aXR1ZGUgOTQyMC4KClNpZ25lZC1vZmYtYnk6IEhh
bnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy91c2IvbWlzYy91
c2ItbGpjYS5jIHwgMzAgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tCiAxIGZpbGUgY2hh
bmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL3VzYi9taXNjL3VzYi1samNhLmMgYi9kcml2ZXJzL3VzYi9taXNjL3VzYi1samNhLmMKaW5k
ZXggNGIwYTc3NzI1YmRkLi44MmI4ZTFlYTZiYmIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdXNiL21p
c2MvdXNiLWxqY2EuYworKysgYi9kcml2ZXJzL3VzYi9taXNjL3VzYi1samNhLmMKQEAgLTM0OSw2
ICszNDksNyBAQCBFWFBPUlRfU1lNQk9MX05TX0dQTChsamNhX3VucmVnaXN0ZXJfZXZlbnRfY2Is
IExKQ0EpOwogI2lmZGVmIENPTkZJR19BQ1BJCiBzdHJ1Y3QgbGpjYV9tYXRjaF9pZHNfd2Fsa19k
YXRhIHsKIAljb25zdCBzdHJ1Y3QgYWNwaV9kZXZpY2VfaWQgKmlkczsKKwljb25zdCBjaGFyICp1
aWQ7CiAJc3RydWN0IGFjcGlfZGV2aWNlICphZGV2OwogfTsKIApAQCAtMzc5LDIzICszODAsMzQg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhY3BpX2RldmljZV9pZCBsamNhX3NwaV9oaWRzW10gPSB7
CiBzdGF0aWMgaW50IGxqY2FfbWF0Y2hfZGV2aWNlX2lkcyhzdHJ1Y3QgYWNwaV9kZXZpY2UgKmFk
ZXYsIHZvaWQgKmRhdGEpCiB7CiAJc3RydWN0IGxqY2FfbWF0Y2hfaWRzX3dhbGtfZGF0YSAqd2Qg
PSBkYXRhOworCWNvbnN0IGNoYXIgKnVpZCA9IGFjcGlfZGV2aWNlX3VpZChhZGV2KTsKIAotCWlm
ICghYWNwaV9tYXRjaF9kZXZpY2VfaWRzKGFkZXYsIHdkLT5pZHMpKSB7Ci0JCXdkLT5hZGV2ID0g
YWRldjsKLQkJcmV0dXJuIDE7Ci0JfQorCWlmIChhY3BpX21hdGNoX2RldmljZV9pZHMoYWRldiwg
d2QtPmlkcykpCisJCXJldHVybiAwOwogCi0JcmV0dXJuIDA7CisJaWYgKCF3ZC0+dWlkKQorCQln
b3RvIG1hdGNoOworCisJaWYgKCF1aWQpCisJCXVpZCA9ICIwIjsKKworCWlmIChzdHJjbXAodWlk
LCB3ZC0+dWlkKSkKKwkJcmV0dXJuIDA7CisKK21hdGNoOgorCXdkLT5hZGV2ID0gYWRldjsKKwly
ZXR1cm4gMTsKIH0KIAogLyogYmluZCBhdXhpbGlhcnkgZGV2aWNlIHRvIGFjcGkgZGV2aWNlICov
CiBzdGF0aWMgdm9pZCBsamNhX2F1eGRldl9hY3BpX2JpbmQoc3RydWN0IGxqY2FfYWRhcHRlciAq
YWRhcCwKIAkJCQkgIHN0cnVjdCBhdXhpbGlhcnlfZGV2aWNlICphdXhkZXYsCi0JCQkJICB1NjQg
YWRyKQorCQkJCSAgdTY0IGFkciwgdTggaWQpCiB7CiAJc3RydWN0IGxqY2FfbWF0Y2hfaWRzX3dh
bGtfZGF0YSB3ZCA9IHsgMCB9OwogCXN0cnVjdCBhY3BpX2RldmljZSAqcGFyZW50LCAqYWRldjsK
IAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBhZGFwLT5kZXY7CisJY2hhciB1aWRbNF07CiAKIAlwYXJl
bnQgPSBBQ1BJX0NPTVBBTklPTihkZXYpOwogCWlmICghcGFyZW50KQpAQCAtNDIxLDYgKzQzMyw4
IEBAIHN0YXRpYyB2b2lkIGxqY2FfYXV4ZGV2X2FjcGlfYmluZChzdHJ1Y3QgbGpjYV9hZGFwdGVy
ICphZGFwLAogCQlicmVhazsKIAljYXNlIExKQ0FfSTJDMV9BQ1BJX0FEUjoKIAljYXNlIExKQ0Ff
STJDMl9BQ1BJX0FEUjoKKwkJc25wcmludGYodWlkLCBzaXplb2YodWlkKSwgIiVkIiwgaWQpOwor
CQl3ZC51aWQgPSB1aWQ7CiAJCXdkLmlkcyA9IGxqY2FfaTJjX2hpZHM7CiAJCWJyZWFrOwogCWNh
c2UgTEpDQV9TUEkxX0FDUElfQURSOgpAQCAtNDQ5LDcgKzQ2Myw3IEBAIHN0YXRpYyB2b2lkIGxq
Y2FfYXV4ZGV2X2FjcGlfYmluZChzdHJ1Y3QgbGpjYV9hZGFwdGVyICphZGFwLAogI2Vsc2UKIHN0
YXRpYyB2b2lkIGxqY2FfYXV4ZGV2X2FjcGlfYmluZChzdHJ1Y3QgbGpjYV9hZGFwdGVyICphZGFw
LAogCQkJCSAgc3RydWN0IGF1eGlsaWFyeV9kZXZpY2UgKmF1eGRldiwKLQkJCQkgIHU2NCBhZHIp
CisJCQkJICB1NjQgYWRyLCB1OCBpZCkKIHsKIH0KICNlbmRpZgpAQCAtNDg5LDcgKzUwMyw3IEBA
IHN0YXRpYyBpbnQgbGpjYV9uZXdfY2xpZW50X2RldmljZShzdHJ1Y3QgbGpjYV9hZGFwdGVyICph
ZGFwLCB1OCB0eXBlLCB1OCBpZCwKIAlpZiAocmV0KQogCQlnb3RvIGVycl9mcmVlOwogCi0JbGpj
YV9hdXhkZXZfYWNwaV9iaW5kKGFkYXAsIGF1eGRldiwgYWRyKTsKKwlsamNhX2F1eGRldl9hY3Bp
X2JpbmQoYWRhcCwgYXV4ZGV2LCBhZHIsIGlkKTsKIAogCXJldCA9IGF1eGlsaWFyeV9kZXZpY2Vf
YWRkKGF1eGRldik7CiAJaWYgKHJldCkKLS0gCjIuNDEuMAoK
--------------Hu3v8sgYmgcWz7S6vFvyqoA4
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-i2c-ljca-Call-acpi_dev_clear_dependencies.patch"
Content-Disposition: attachment;
 filename="0002-i2c-ljca-Call-acpi_dev_clear_dependencies.patch"
Content-Transfer-Encoding: base64

RnJvbSBkZmEzYmIzZDVmNDAzYjM2Yjc3OTUwOWI5ZGNmYmYxMTE0ZWViZWUyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPgpE
YXRlOiBGcmksIDEgU2VwIDIwMjMgMTk6NDc6NDggKzAyMDAKU3ViamVjdDogW1BBVENIIDIvNF0g
aTJjOiBsamNhOiBDYWxsIGFjcGlfZGV2X2NsZWFyX2RlcGVuZGVuY2llcygpCgpDYWxsIGFjcGlf
ZGV2X2NsZWFyX2RlcGVuZGVuY2llcygpIHRvIG1hcmsgX0RFUCBBQ1BJIGRlcGVuZGVuY2llcyBv
bgp0aGUgSTJDIGNvbnRyb2xsZXIgYXMgc2F0aXNmaWVkIHNvIHRoYXQgYWNwaV9kZXZfcmVhZHlf
Zm9yX2VudW1lcmF0aW9uKCkKZm9yIHRoZSBJMkMgZGV2aWNlIG5vZGVzIGluIEFQQ0kgd2lsbCBy
ZXR1cm4gdHJ1ZSBvbmNlIHRoZSBJMkMgY29udHJvbGxlcgppcyByZWdpc3RlcmVkLgoKU2lnbmVk
LW9mZi1ieTogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4KLS0tCiBkcml2ZXJz
L2kyYy9idXNzZXMvaTJjLWxqY2EuYyB8IDkgKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgOCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMvYnVz
c2VzL2kyYy1samNhLmMgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWxqY2EuYwppbmRleCAzNTcy
MzQ4OTRkZWEuLjNhZmY0ZGU1MjkyMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9pMmMvYnVzc2VzL2ky
Yy1samNhLmMKKysrIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1samNhLmMKQEAgLTMwMyw3ICsz
MDMsMTQgQEAgc3RhdGljIGludCBsamNhX2kyY19wcm9iZShzdHJ1Y3QgYXV4aWxpYXJ5X2Rldmlj
ZSAqYXV4ZGV2LAogCQkJCSAgICAgImkyYyBpbml0IGZhaWxlZCBpZDogJWRcbiIsCiAJCQkJICAg
ICBsamNhX2kyYy0+aTJjX2luZm8tPmlkKTsKIAotCXJldHVybiBkZXZtX2kyY19hZGRfYWRhcHRl
cigmYXV4ZGV2LT5kZXYsICZsamNhX2kyYy0+YWRhcCk7CisJcmV0ID0gZGV2bV9pMmNfYWRkX2Fk
YXB0ZXIoJmF1eGRldi0+ZGV2LCAmbGpjYV9pMmMtPmFkYXApOworCWlmIChyZXQpCisJCXJldHVy
biByZXQ7CisKKwlpZiAoaGFzX2FjcGlfY29tcGFuaW9uKCZsamNhX2kyYy0+YWRhcC5kZXYpKQor
CQlhY3BpX2Rldl9jbGVhcl9kZXBlbmRlbmNpZXMoQUNQSV9DT01QQU5JT04oJmxqY2FfaTJjLT5h
ZGFwLmRldikpOworCisJcmV0dXJuIDA7CiB9CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXV4aWxp
YXJ5X2RldmljZV9pZCBsamNhX2kyY19pZF90YWJsZVtdID0gewotLSAKMi40MS4wCgo=
--------------Hu3v8sgYmgcWz7S6vFvyqoA4--

