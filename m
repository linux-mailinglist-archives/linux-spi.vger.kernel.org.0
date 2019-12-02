Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18D9A10EA32
	for <lists+linux-spi@lfdr.de>; Mon,  2 Dec 2019 13:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfLBMnw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Dec 2019 07:43:52 -0500
Received: from mx07-00252a01.pphosted.com ([62.209.51.214]:63270 "EHLO
        mx07-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727354AbfLBMnw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Dec 2019 07:43:52 -0500
X-Greylist: delayed 2015 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Dec 2019 07:43:50 EST
Received: from pps.filterd (m0102628.ppops.net [127.0.0.1])
        by mx07-00252a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB2CADei022598
        for <linux-spi@vger.kernel.org>; Mon, 2 Dec 2019 12:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=to : from :
 subject : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=pp;
 bh=Jqjk1YIYJn09xCowXcBKwYry3d3CxcwldaQy0bAF4+Q=;
 b=ye7zMlpJR3K0oiKdI1QMduVk7tY2kJyhnj3y46J0yDCTrDylhzq+JRt02wYbKN6XQfpl
 Y1z6DAt5e+zeOqZjM31VrHxrQukj62ClgFCtCkkIb3Xbgf2r74nMAz9e38cSu+GExJhL
 qCsz+dfL9RoPeQ/QibgLW0xo6cbDAEn2w5+rtAUwQ2dC80NvfCNzwyUhvccRyxoixvwx
 YNTluRn2RDNIchFbkUqzhwDa7ti+iqA+QUJhmlk+edfSJ4HPNy5ptcUIO1KiK8tTX9u0
 xrZIJ2KOgIXNBl91xDdXe3RS/TCKYEFup9x+esvBPAuUAYYiHowXIpgDkAN0Gn6nQY9O tQ== 
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        by mx07-00252a01.pphosted.com with ESMTP id 2wkeq98ybw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-spi@vger.kernel.org>; Mon, 02 Dec 2019 12:10:14 +0000
Received: by mail-wm1-f69.google.com with SMTP id z3so5849362wmk.1
        for <linux-spi@vger.kernel.org>; Mon, 02 Dec 2019 04:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Jqjk1YIYJn09xCowXcBKwYry3d3CxcwldaQy0bAF4+Q=;
        b=FCx0/xtSaEZd5n1dRnLS5YgywVF5YHdqRHUzSIv80/ZUdXam1fBRjDRo0Tohbx3/8s
         a58nYgK5T0QMJ3NeM9mYoG7dkQituE9MDLZ2HWh71C0kggGxqqDQhCZhtQaQqB7LFfDM
         RFnlZRfBiyUmF0y0wCUgBBapOjqrvuG8Ph6hFvCAFrsiZvFHIZjZya/eYmQVH4gsjj6k
         +JjmF6jaozJr0/c0c7WThu27+tMscESWrSGfWAfHbEZVpl3qPmJuRDVEjksQCeMRzPkl
         u2/TEZafqnV95BUBbd9xpic+rv7fxm/t3jpan5uh9FqL25rqbW71BYciP2qUKCgmc7LA
         K6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Jqjk1YIYJn09xCowXcBKwYry3d3CxcwldaQy0bAF4+Q=;
        b=BIHNtS7aR0VoFRbaSzTsNt0P1/aAIu/27PTHf7dKUrZHA7543gq71gnkMK0urgQDWg
         p4SZaXl4wOnM0ZBCMZaR96GQI5zWXn6+IDD0o+UtPp5Ra0ZqMNNMaaeS7j7Ghx/p0k5A
         AOHv+Ukoc2yK1Bo0hdaZrMB4UcBljN7pXg+hjzNvObbhDkq5VozklUBtHeM3/nP65GSf
         6jwWNU1d3Ns9sEvg8Q1c9TCAl20iYJlvkpMvITGcOgVJ70LcJyooK8pAtp1yekdTaJEs
         FVuzef3snT7jEUtgaMdEftWJnGpbKaEQ9UTZHhnTKiCIYL/dz7jpL1vxCfgxmIrdpi7u
         sjKA==
X-Gm-Message-State: APjAAAUe96zpvaik2M3gFj5FqzEpeiCnBqf8sEY59R8oJV5ppnLzsbgX
        u3ShJLE+eSK1I4gL3kgKETn6DH3XutKf0PYkznBm1s+rDzJJXSAzqxz0fJtgz0oLp/iBbQrQ/Ih
        UuRvgaEIvmmnNIbXbNHFe
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr26990123wmi.152.1575288613229;
        Mon, 02 Dec 2019 04:10:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqwduwi43ZhC6mYLsHsLeSw0dSkkpop68I1FsryXHBy7xeaVzmFCWlAfOi7ks19Ajav/5siL1Q==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr26990086wmi.152.1575288612940;
        Mon, 02 Dec 2019 04:10:12 -0800 (PST)
Received: from ?IPv6:2a00:1098:3142:14:c5ae:b42a:dc72:b89c? ([2a00:1098:3142:14:c5ae:b42a:dc72:b89c])
        by smtp.gmail.com with ESMTPSA id d12sm14591659wrp.62.2019.12.02.04.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 04:10:12 -0800 (PST)
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
From:   Phil Elwell <phil@raspberrypi.org>
Subject: Side effect of SPI GPIO descriptor usage
Message-ID: <db6a1e17-49a3-e3ed-7713-56b7763713d6@raspberrypi.org>
Date:   Mon, 2 Dec 2019 12:10:11 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_02:2019-11-29,2019-12-02 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

A relatively recent patch [1] to the spi-bcm2835 driver modified it to 
use GPIO descriptors for chip select handling. A side effect of this 
change is to set the SPI_MODE_CS_HIGH flag for devices connected to the 
controller, which seems strange since it happens for devices that 
require the usual active-low chip select.

This change came to light when a user reported that the SPI-Py library
(a client of the spidev driver) wasn't working on 5.4, which was traced 
to it overwriting the SPI mode flags when it was only trying to set the
CPHA and CPOL flags. This had the affect of inverting the chip select
line, with the obvious consequences. That corruption of the flags is 
clearly an error, but what if the application and library were genuinely 
trying to specify that the attached device required an active-high chip 
select? Would it now require that they _clear_ the CS_HIGH flag?

Thanks,

Phil

[1] 3bd158c56a56 ("spi: bcm2835: Convert to use CS GPIO descriptors")
