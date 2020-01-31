Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A161814F379
	for <lists+linux-spi@lfdr.de>; Fri, 31 Jan 2020 21:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgAaU4d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 31 Jan 2020 15:56:33 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:50298 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgAaU4d (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 31 Jan 2020 15:56:33 -0500
Received: by mail-wm1-f53.google.com with SMTP id a5so9448214wmb.0
        for <linux-spi@vger.kernel.org>; Fri, 31 Jan 2020 12:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qeqPjZUqrP7rylxuw1Ghw9c98ZrrLm2fQathxhc6jqM=;
        b=FwB+T6/XymHVOg/RJNzQ3uvyWhwLnB7+ZNaT1TN5lwQSy4P8QRJq3GOdftG1B3flY/
         IoQwC63ESUbfc9iLP30kjxQqdzAgTH9MY7E0lc555R64bCE/fxqpa4XDbaUUv4ak5o1+
         SLBhaBbfjeAfgsaN0d+G8eIy1BoUR0SNZyQrgANh56HdlEkj+AnE+TnuSPVWNDjCYspO
         OK95migr+EZ+m8erSGSk+d0ITe7oaK3tnWV8xjKUhyJL20GLRLoVlj0mLekPM0qEH1/j
         qR+A2Wz1+KvHXZEvnWbACgKx3n3+NNQxyEDl+jh98BKedisUejpFeFQ9m5n/3FcogxMF
         SaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qeqPjZUqrP7rylxuw1Ghw9c98ZrrLm2fQathxhc6jqM=;
        b=kiWTCAZc9Q6jKKCq7T0futaicd0X842dsyut+EtFaMQSruowcwzLR1HkiPne7X/p8w
         K3tPZk4qVVjdAhlAzmK7HwBYMyNNu/ZlBXK8bMTvb4g7GQOQPa7vtz5ZBSaEG2B5FU02
         Cnfg/p/E+HVg0Jp+5LGd8FZV9/FoIelg799wcxzlP9fIB1+d2dMZzlrOBKawnUnqoRsK
         t0eZ0qlpTSAUGOd6IWZhAAfvkvUPtgILg2TpOcWRe2omteGyx1ollq2cQXnJXUJz8G3U
         Ha5VKfDZb+r+m7SSV7t83u8Bx+mN+qjcN69FuopxgweYXi0YVdfN5rQtngJVQVVICz+H
         X0Ng==
X-Gm-Message-State: APjAAAX3IwQagVC3Ftc8E6V8/AhD46SU/O48VGBlk0tIiQtnJOBJXCWN
        YIRqxiy4A77xCoGR6i+5AWiY9G+h
X-Google-Smtp-Source: APXvYqzgkcKcHvzIFGYZ67ZijQnCqwji2XOmv3rZzqJXMDHztVVfL+ruzwhORp1V4kB0dEmEQcKYCQ==
X-Received: by 2002:a7b:c934:: with SMTP id h20mr13841260wml.103.1580504191187;
        Fri, 31 Jan 2020 12:56:31 -0800 (PST)
Received: from ?IPv6:2003:ea:8f29:6000:8922:4c51:f8d2:7862? (p200300EA8F29600089224C51F8D27862.dip0.t-ipconnect.de. [2003:ea:8f29:6000:8922:4c51:f8d2:7862])
        by smtp.googlemail.com with ESMTPSA id z10sm11674967wmk.31.2020.01.31.12.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 12:56:30 -0800 (PST)
Subject: Re: spi-fsl-espi driver issue
To:     Andrij Abyzov <drolevar@gmail.com>
References: <CADQNx5QsXRSyrJxEXLQr3oYyy+-xnYrH_txbA+37macNVZkHcw@mail.gmail.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <712e53ad-9482-d767-7995-35634e58e5bd@gmail.com>
Date:   Fri, 31 Jan 2020 21:48:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CADQNx5QsXRSyrJxEXLQr3oYyy+-xnYrH_txbA+37macNVZkHcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 31.01.2020 10:34, Andrij Abyzov wrote:
> Heiner,
> 
> I'm having a strange issue with the spi-fsl-espi driver when updating the firmware on Lattice MachXO2 FPGA.
> It worked fine with the version 4.9, however one of the subsequent changes has led to the issue, that the read result is shifted right by 1 bit.
> I understand this could be something due to polarity, phase or frequency, but it did work fine with 4.9 and before.
> Now I'm trying to localize the issue by bisection, but that's a lengthy process and I thought that maybe you could have some insights.
> 
I'm not the maintainer of this driver, so better set the linux-spi list on cc.

Which device tree config is used? Or do you set a specific mode manually?

> Best regards,
> Andrij Abyzov

Heiner
