Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6684655D7
	for <lists+linux-spi@lfdr.de>; Wed,  1 Dec 2021 19:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352422AbhLASwy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Dec 2021 13:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244640AbhLASwx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 Dec 2021 13:52:53 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD18C061574
        for <linux-spi@vger.kernel.org>; Wed,  1 Dec 2021 10:49:31 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id y196so21203024wmc.3
        for <linux-spi@vger.kernel.org>; Wed, 01 Dec 2021 10:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=1cg6hKlzdOFCFDKJ16LzubOp4ckqXjPMWvupP9/xzgU=;
        b=puh/BJJYyMLxgXZUyN8eR8IiXVPdSmeLpg2MyQiXXWdKXCov91EOAvy6hNTRxQaH/d
         Z5+KP5xyexKCwN0p2dy282evXxEmQliie3OzgQNY0AFmj6PbOZHFptbovWb8YfjdTJHS
         QrJehLzkvIwqLcZ1GPFm4v71RcwdaxStwheAIxcA9LiJg1kh1qB624SIjreezvVH6i9d
         6b3qMLSDDitfvndyzgkfn86r3syvZ5OyybiR5ECAxBN+vA1hBu7gQTZMLfgA4yTiyMbU
         8O688aUVbKbu+QkTZCc1+RQOVlh9TXLOGm4BgtqGVLRYaE7vwC52h00/WSOhK+pCh0up
         lEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=1cg6hKlzdOFCFDKJ16LzubOp4ckqXjPMWvupP9/xzgU=;
        b=VvP6PoD2IXEJ0Bmv6IJo/DUdryBDJNxrcTKcn8N12pxz4UJU4UulUxkq320ZyeWXbK
         uvWmLFNm0VM4QeqJIAhBYRMew/33QWCZpsfYh4mTmek1LAQ1YG/bCe4xYxiQGZQ+1sz4
         bhOJfdWq8TYsiylGod4PRLWvdx5OYtKZlnT0bcee076d1mDVJtt2iPE5J+7emxiSTuuL
         3815zHscyCxuB3nuIhuQCFxWSovIXFpMSFiwLXxIFkNy4I4+GCSmje2OIOh6+lfwQjRP
         ETWIyUHnAdmWd70By2vhPxTvaOPYFkVUM/DMJxEHZyZ7/hpkjHeGU3Wy9GZ5m8Mn83Qn
         FT3A==
X-Gm-Message-State: AOAM533WP1BCsuCx9hPOo1QpeDNlPa+1Lw+sW45eSR7+FcQ6TEmhZ3ex
        cfjeV3mT/bnurV1rhPSeqxg=
X-Google-Smtp-Source: ABdhPJz+gQ53EmloBRGcfPMqLpqYK78rzrqfHYf0YjTsIWlzEN4dT3A1tCDRQ0OQ/LiZmByP6vOWVg==
X-Received: by 2002:a05:600c:3489:: with SMTP id a9mr9345692wmq.53.1638384570438;
        Wed, 01 Dec 2021 10:49:30 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1a:f00:48a2:678b:f140:db00? (p200300ea8f1a0f0048a2678bf140db00.dip0.t-ipconnect.de. [2003:ea:8f1a:f00:48a2:678b:f140:db00])
        by smtp.googlemail.com with ESMTPSA id z5sm124182wmp.26.2021.12.01.10.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 10:49:29 -0800 (PST)
Message-ID: <043b15ea-968c-60cb-dc50-c2081105975a@gmail.com>
Date:   Wed, 1 Dec 2021 19:49:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
References: <44b2ad71-dc4b-801c-237f-9c233f675c0d@gmail.com>
 <YaeXoiFRAcxVG3I3@sirena.org.uk>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] spi: fix erroneous logic inversion in spi_match_id()
 usage
In-Reply-To: <YaeXoiFRAcxVG3I3@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 01.12.2021 16:41, Mark Brown wrote:
> On Tue, Nov 30, 2021 at 09:13:35PM +0100, Heiner Kallweit wrote:
> 
>> We want to continue in case of a match. Fix the erroneously inverted
>> logic.
> 
> We do?  Why?  I can't tell from this changelog what the problem is or
> why the patch would fix it.
> 

That's the relevant part of 3f07657506df. Before this change we hit the
continue path if spi_id->name[0] != NULL, means if a match was found.
spi_match_id() returns NULL if no match was found. The commit message
of 3f07657506df doesn't mention an intention to change the logic.

@@ -474,12 +473,8 @@ int __spi_register_driver(struct module *owner, struct spi_driver *sdrv)
 			if (sdrv->id_table) {
 				const struct spi_device_id *spi_id;
 
-				for (spi_id = sdrv->id_table; spi_id->name[0];
-				     spi_id++)
-					if (strcmp(spi_id->name, of_name) == 0)
-						break;
-
-				if (spi_id->name[0])
+				spi_id = spi_match_id(sdrv->id_table, of_name);
+				if (!spi_id)
 					continue;
 			} else {

>> @@ -471,10 +471,7 @@ int __spi_register_driver(struct module *owner, struct spi_driver *sdrv)
>>  				of_name = of_id->compatible;
>>  
>>  			if (sdrv->id_table) {
>> -				const struct spi_device_id *spi_id;
>> -
>> -				spi_id = spi_match_id(sdrv->id_table, of_name);
>> -				if (!spi_id)
>> +				if (spi_match_id(sdrv->id_table, of_name))
>>  					continue;
>>  			} else {
>>  				if (strcmp(sdrv->driver.name, of_name) == 0)
> 
> This appears to correspond to the current code anyway?
> 
No. Now we (again) continue if spi_match_id() != NULL.
