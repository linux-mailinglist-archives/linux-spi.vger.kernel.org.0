Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1E95151938
	for <lists+linux-spi@lfdr.de>; Tue,  4 Feb 2020 12:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgBDLFh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Feb 2020 06:05:37 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33167 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgBDLFg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Feb 2020 06:05:36 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so9508669pgk.0;
        Tue, 04 Feb 2020 03:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GxykDE+DcSQ1crfYhERdL+BbFmIFCQ49WGPIUjHJPuI=;
        b=PjRmx6CLUbaArMl7uReXuzNpRv2gR74IIlHJCMoKq1qCFS6axGVFPV2TJGlq1C+3N0
         7bmCb2k5wItR1sZ7GtTNnFO5OULU6VbGPODrBq4NFI7QF6K8ZhP4wcjTxA4eAakPWZ2C
         FtMmYpNsbW0XS9nxOlwg0GcugRb4CNfOdTWYi7wR8vvAkOV+S3OXZyqPbWjJI5iMARt6
         cqYhJqkBK9nb0FQA54S0EZjue6wnkVy3CxVeB1f3Zu8JbS7cMenEDDtBAALQBmKDKpFN
         pM8OZU293sEX9mYR15FBqyNVTJFpKPee5kwRsnLPpGnvKoOKN/V2n/pl4T8E7UkQuPIW
         wNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GxykDE+DcSQ1crfYhERdL+BbFmIFCQ49WGPIUjHJPuI=;
        b=aprHGfbNWlwzeEv+rsVqDoIbkZkYIUKrPXE99CF5GcO+qzXmGI/ChDfJV2rEiN30bz
         CfnFTJBCyDG2iemMjjgRG7hAa77hHHnCH/EN0yxKYrL1gSnbRj13MBtCCxB2+dyAeiaj
         NdBXnU53kIB/sJshQQT4GzFovLEB6Cc+KSHJhwF8kGNEOCfRFnKAsk5AdbnBOJnBeMmP
         UR/3wGcpJyeipQdia+il0wsDU+iMB5D0X7yK+biVIu/x/QJatYyhd8o8ME9ZCQ2ucMku
         ksZKg1uyuc8wh0TW2YMxaQqg3TtvhtcIDnTprs8LtCJb7pEye36jk0ZhyJydVHZ3u+Y6
         /9DA==
X-Gm-Message-State: APjAAAW6Kim/kGTbS3ylrcUeaWKt774xFQcJOx14oKNYd/PwzdIsdrHT
        GwDlRI4OxR2uU32wRtNlrrN/CD6/AwJQ3nKNGqxF+akSqYQ=
X-Google-Smtp-Source: APXvYqx2OK4gV7xlnE3taG7vOCZL2ndsFgf07QjvdlOnwm6k0NWOdOBJooLzABA1idpH5vCPxgWevny8Z+JU3e8kh7E=
X-Received: by 2002:a62:52d0:: with SMTP id g199mr29444152pfb.241.1580814336043;
 Tue, 04 Feb 2020 03:05:36 -0800 (PST)
MIME-Version: 1.0
References: <20200203223003.4567-1-eajames@linux.ibm.com>
In-Reply-To: <20200203223003.4567-1-eajames@linux.ibm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Feb 2020 13:05:28 +0200
Message-ID: <CAHp75VfHAS46-kMyg7Ky4jn7zmkht6wd9ayCfn+rrO0R6aNr6A@mail.gmail.com>
Subject: Re: [PATCH v2] spi: Add FSI-attached SPI controller driver
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Feb 4, 2020 at 12:30 AM Eddie James <eajames@linux.ibm.com> wrote:
>
> There exists a set of SPI controllers on some POWER processors that may
> be accessed through the FSI bus. Add a driver to traverse the FSI CFAM
> engine that can access and drive the SPI controllers. This driver would
> typically be used by a baseboard management controller (BMC).
>
> The SPI controllers operate by means of programming a sequencing engine
> which automatically manages the usual SPI protocol buses. The driver
> programs each transfer into the sequencer as various operations
> specifying the slave chip and shifting data in and out on the lines.

Some comments left unsettled in v1, thus applicable here.

-- 
With Best Regards,
Andy Shevchenko
