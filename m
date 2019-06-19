Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D75B34B78C
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2019 14:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731526AbfFSMAM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Jun 2019 08:00:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34580 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfFSMAL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Jun 2019 08:00:11 -0400
Received: by mail-io1-f68.google.com with SMTP id k8so7344060iot.1
        for <linux-spi@vger.kernel.org>; Wed, 19 Jun 2019 05:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yULoWsPxvpwhEKQeqlB3rwd0CyoBaZXR3zMq8ur6KTk=;
        b=We8TA2TvglD2LggDUKTGR1uEQRExA/uA2y4sPO1bHLkEkJxr2WpvtbQeI5AIbAgwdy
         KOGOcpEkmUZG/UYcSjOWymDTGudABT48FS0O50kMiyXX+5yTssrj2Mj1Qv+P2uzzjdia
         1x3hA3gAsQASNMZjGIPFaSVrnlC7XenYiusHydcU/E4wvDshEVbBqaKRWY6J3AGxOxL9
         xBiSg1XEUy7gnM5UJyQTtKLYrgp/w2zEqpZsbds3MA4H/cseF1JFmcnEiCCpZgWZPRNK
         r8hQNYXfrd/lc1dQNTrh7zeUwfQoGNOFlW7M6bJE4SQ2ci27534QuFk/nvjIVuyYyThn
         Wm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yULoWsPxvpwhEKQeqlB3rwd0CyoBaZXR3zMq8ur6KTk=;
        b=VQHDwDSAwLLYEWjOD+KSn4bR9byZNFs8xvcK0zj+OA0ej80jXEzYbnY+p8ljSLSID6
         hELhWTVq6EnzfQi8Tk83gK8bb4TDr7xQlNA1xmHJ2Oaux5jywlVvVBdIZO7phA9IxOj9
         O4+MiFIB1QnWgMARll1mxFigaYYhVb8Qvpj7/hupz9edEFXYLNE5phIWS197iQ3fb7fh
         v5/CKWUwjAnzTBrxLQtCr5EawFH+/NJlyjuJgnXfhK1NWnfvWQ0hnC2oM3G5HR7LdILL
         aqScWXBOVTnytvcg8N6uAmb2juU+tNDmMdykKBea+CvjMFntJRB2T7wWErdqqkiQKdnq
         idtA==
X-Gm-Message-State: APjAAAXQ8HvrkvoeQ7iqE4bz6uSsQfRL1KkYN1yp1tzQp2MjQNo6jTX/
        e4oVa2fcqTGaeUK3p1IYWeQgCZ8O5VIizHxT8lfj8Q==
X-Google-Smtp-Source: APXvYqyaPZ2TbevY59IpMTZWufpjvxPeZ1pKqAlhgVKAI9OzMw3Yl8ShN8mHzt6QIBw+P7/Lw5eLK7A8zQKgGt6A5Ys=
X-Received: by 2002:a6b:7312:: with SMTP id e18mr4811346ioh.156.1560945610493;
 Wed, 19 Jun 2019 05:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190619095254.19559-1-ard.biesheuvel@linaro.org>
 <20190619101604.GR2640@lahna.fi.intel.com> <54ede1d8-0e6b-e7d9-5e61-a7d057abbd2b@linux.intel.com>
In-Reply-To: <54ede1d8-0e6b-e7d9-5e61-a7d057abbd2b@linux.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 19 Jun 2019 13:59:58 +0200
Message-ID: <CAKv+Gu_Bw3aV-pUVYf8T1hLfL35X7ozEPtqL9oLcDvwcQ4qMiw@mail.gmail.com>
Subject: Re: [PATCH] spi/acpi: fix incorrect ACPI parent check
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 19 Jun 2019 at 13:58, Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
>
> On 6/19/19 1:16 PM, Mika Westerberg wrote:
> > On Wed, Jun 19, 2019 at 11:52:54AM +0200, Ard Biesheuvel wrote:
> >> The ACPI device object parsing code for SPI slaves enumerates the
> >> entire ACPI namespace to look for devices that refer to the master
> >> in question via the 'resource_source' field in the 'SPISerialBus'
> >> resource. If that field does not refer to a valid ACPI device or
> >> if it refers to the wrong SPI master, we should disregard the
> >> device.
> >>
> >> Current, the valid device check is wrong, since it gets the
> >> polarity of 'status' wrong. This could cause issues if the
> >> 'resource_source' field is bogus but parent_handle happens to
> >> refer to the correct master (which is not entirely imaginary
> >> since this code runs in a loop)
> >>
> >> So test for ACPI_FAILURE() instead, to make the code more
> >> self explanatory.
> >>
> >> Fixes: 4c3c59544f33 ("spi/acpi: enumerate all SPI slaves in the namespace")
> >> Reported-by: kbuild test robot <lkp@intel.com>
> >> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> >
> > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >
> I hit yesterday a regression caused by 4c3c59544f33. I've a custom ACPI
> tables defining I2C gpio expanders (gpio-pca953x.c as INT3491) and a
> spidev test device (SPT0001).
>
> Both stopped enumerating after 4c3c59544f33. With this fix spidev device
> enumerates but still get confused with I2C GPIO expanders (INT3491):
>

Could you share the decomplied D/SSDT please?

> [    5.629874][    T1] pxa2xx-spi pxa2xx-spi.3: registered master spi3
> [    5.644447][    T1] pxa2xx-spi pxa2xx-spi.5: registered master spi5
> [    5.653930][    T1] spi spi-SPT0001:00: in setup: DMA burst size set to 8
> [    5.661300][    T1] spi spi-SPT0001:00: setup mode 0, 8 bits/w,
> 1000000 Hz max --> 0
> [    5.671360][    T1] spidev spi-SPT0001:00: do not use this driver in
> production systems!
> [    5.682325][    T1] pxa2xx-spi pxa2xx-spi.5: registered child
> spi-SPT0001:00
> [    5.690240][    T1] spi spi-PRP0001:00: in setup: DMA burst size set to 8
> [    5.697492][    T1] spi spi-PRP0001:00: setup mode 0, 8 bits/w,
> 20000000 Hz max --> 0
> [    5.706928][    T1] pxa2xx-spi pxa2xx-spi.5: registered child
> spi-PRP0001:00
> [    5.715754][    T1] pxa2xx-spi pxa2xx-spi.5: cs104 >= max 4
> [    5.721688][    T1] spi_master spi5: failed to add SPI device
> INT3491:00 from ACPI
> [    5.730648][    T1] pxa2xx-spi pxa2xx-spi.5: cs104 >= max 4
> [    5.736657][    T1] spi_master spi5: failed to add SPI device
> INT3491:01 from ACPI
> [    5.745617][    T1] pxa2xx-spi pxa2xx-spi.5: cs104 >= max 4
> [    5.751546][    T1] spi_master spi5: failed to add SPI device
> INT3491:02 from ACPI
> [    5.760628][    T1] pxa2xx-spi pxa2xx-spi.5: cs104 >= max 4
> [    5.766549][    T1] spi_master spi5: failed to add SPI device
> INT3491:03 from ACPI
> [    5.777160][    T1] pxa2xx-spi pxa2xx-spi.5: cs104 >= max 4
> [    5.783087][    T1] spi_master spi5: failed to add SPI device
> BCM2E95:00 from ACPI
> [    5.797008][    T1] pxa2xx-spi pxa2xx-spi.6: registered master spi6
>
> Ok log with commit 4c3c59544f33 reverted:
>
> [    5.633116][    T1] pxa2xx-spi pxa2xx-spi.3: registered master spi3
> [    5.647701][    T1] pxa2xx-spi pxa2xx-spi.5: registered master spi5
> [    5.655668][    T1] spi spi-SPT0001:00: in setup: DMA burst size set to 8
> [    5.663066][    T1] spi spi-SPT0001:00: setup mode 0, 8 bits/w,
> 1000000 Hz max --> 0
> [    5.672758][    T1] pxa2xx-spi pxa2xx-spi.5: registered child
> spi-SPT0001:00
> [    5.680602][    T1] spi spi-PRP0001:00: in setup: DMA burst size set to 8
> [    5.687820][    T1] spi spi-PRP0001:00: setup mode 0, 8 bits/w,
> 20000000 Hz max --> 0
> [    5.697366][    T1] pxa2xx-spi pxa2xx-spi.5: registered child
> spi-PRP0001:00
> [    5.709064][    T1] pxa2xx-spi pxa2xx-spi.6: registered master spi6
> [   11.021760][   T84] spidev spi-SPT0001:00: do not use this driver in
> production systems!
>
> --
> Jarkko
