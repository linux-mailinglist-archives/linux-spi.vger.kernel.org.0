Return-Path: <linux-spi+bounces-8106-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A829AB52BE
	for <lists+linux-spi@lfdr.de>; Tue, 13 May 2025 12:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FEBE19E1564
	for <lists+linux-spi@lfdr.de>; Tue, 13 May 2025 10:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A697267F74;
	Tue, 13 May 2025 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KTvQUBt1"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545A42676CD;
	Tue, 13 May 2025 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747131558; cv=fail; b=T8G5X/6t7K5p7KPPHSE8U6Ie0VHJq+uxIN2EAhTv13Q0yPjTgjZ4iaR/BafW4lBaJ0a3Ad/WlqhUilebD5RSW/9kKC/e5MjwzQP0nHI8+durvJGuz/3Mmyoh7uNJqcWI80zTx5JaRJL5jE6tGWMlXDY1LaIljWxf/GCPuLoDFU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747131558; c=relaxed/simple;
	bh=d2+tx512W5BSXAhrU0rMNJG46G/rQskXq7T1bS0j8V0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SWrxNEOte5juk2WvGen7xGUm6AIDZusdxO+VWvZw4p4IfFxX9VICbf/cyK+bcR1f1pn8JPWRkRxjwoNPqn9hYtePR+OQLdV9YFL+GVgCZbc0tcrqXmoyLdQfKyR+C+HJP/tEW/ScwdnnagfQXYwvTG9WNMZF+HQQpgY2/2DEVzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KTvQUBt1; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mes4CFEDLeTwuT7qym60OnKgqkUfwXgsxMUS2qquOVuZeTH9sRtaCd+1acfj5LcnSDijI+HrhVaodtcaK2P9wOYHS4qB6UlxfZU8pHuphOvn/XlrDZdvTsZsyp4ET8EAMblyY7N2QKv40OEZ7YEHEy8rAaGZcA1GZzmDcmbzxI6NXbj9Ua/dtWIPl6RTjuWXnyV0gUzIJRf2o/iUFc+1CZftm9+KZbVDByls8YKWJ12MF8LXqhP4OwOvm5t22thE9MnyG90o9dQjTrMtmCrASNaZ4JpTDLr+MHTrqTRPHvqiq6dCSBlUNE0oKzpnmTmNOTHN1P5BSdfFJUDTXj1T2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QBKAEKnp0u5Pwdp0dktGSuEksx/HqWir8DRoLdD7wY=;
 b=Fiy14qscqIFmpso0R56eGr9NmKGnF5n1SlSp8H9mLSM0cnLT/hFUExm/lT/uBtGnHyRRf5d/8yw9NPlKvfChn1g/HTBQ3nl9+1idNvE14F/lKGlrgNkqEurxNAj7Yr58Ctrjl+uetXc6CS2/NO67dOV6chAnM6buh0EZAl+W/eADeqDdXEuvYAlAexPT0JSePZpKVXzhGoQaEZjZCJx1YYmr58mywAMqaB2/43I6cp+BBRipSrmtDwDChvg8Ze5UXk64SmN2m33p66dIZX67U1oDxzosxluRffvOeNH5BKECyoa6FI5XJnAu3qChtm5gY7otv4TiwGoO0AARZEPm9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QBKAEKnp0u5Pwdp0dktGSuEksx/HqWir8DRoLdD7wY=;
 b=KTvQUBt1lOVSxwVW6RUOen50BhP2Yhn/7Bi1LQhlsUNEcZnLfkLqc+n4tnQy35XHkfr01C9XeCb+ySQQb0dza4Oe7hWXt/Au0Eaf0Z3mSZ/j+9024rJq2oeAf1rrNWz2JWqqNKCcv9LgsMV+GKs1tBqVh5fDhsB0/zheEXRFKXvmNZUCEn11IhAupkjicPz8LjA2SkmEwvUmVolS1nufzqPWfZQEYtAHDR+hGp4sYBIEHzGeBdvR7+pwjJGRpDq2yPy/o2J7vitfA176jRkXaa7RFuE2ea7j1ToFy6jclhEkQfRko1TTEL8Ns9Ld5iXM2awRWQejUc5nbsvID+mknQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SA1PR12MB7246.namprd12.prod.outlook.com (2603:10b6:806:2bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 10:19:12 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 10:19:12 +0000
Message-ID: <904d3e89-a540-4edd-b748-15e13c431c17@nvidia.com>
Date: Tue, 13 May 2025 11:19:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 RESEND 1/2] dt-bindings: spi: tegra: Document IOMMU
 property for Tegra234 QSPI
To: Conor Dooley <conor@kernel.org>, Vishwaroop A <va@nvidia.com>
Cc: krzk@kernel.org, broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, thierry.reding@gmail.com, skomatineni@nvidia.com,
 ldewangan@nvidia.com, kyarlagadda@nvidia.com, smangipudi@nvidia.com,
 bgriffis@nvidia.com, linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250509165409.311912-1-va@nvidia.com>
 <20250512-observant-rental-21927c85c709@spud>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250512-observant-rental-21927c85c709@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0103.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::19) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SA1PR12MB7246:EE_
X-MS-Office365-Filtering-Correlation-Id: b9169c37-20ac-426a-5334-08dd92079aec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1lCQkNrT1NZaHp5cVZBVVo5MHdQOTdEWW1IMm9PbFJmWDRueVE1Q295TFEw?=
 =?utf-8?B?N2Eva0J2MmdZSE9ibjdYMzQzSjFYbFlIYy9EYlRCeDBhOXBwNTZhS3pPa0FF?=
 =?utf-8?B?eVV2Y3VxU1paemRxY3E5TWx4djRmaHZLR0J5YnF0UitnbmFGT292NUtqSFV2?=
 =?utf-8?B?bEl5Rk52NG0vWUQzdHNhWDFYclRyYmtaYlI2QStBNzhvSnNZajBMOC8wTG1O?=
 =?utf-8?B?M01wamlkOVc0NzhEM052anAxdDJJV21oVWlOdWlCRW81OWpGam13UVBhMG5r?=
 =?utf-8?B?eCtDZ255cTR4Q1NOblIvZWlVTldzc3VHRE5yd3ZueWFwLzMwek0xSGpXR1JN?=
 =?utf-8?B?TWVPempwWmVqMjNMcjFKVTZoTSs5dlUzZWJRRld6UjIrMDMrMnM3YjlNVDhK?=
 =?utf-8?B?cmwzNnc2WkxFVktDalVPdWN4SExveWl4ZTlqMFdoZjh4VG8vVkxFS3llc3R4?=
 =?utf-8?B?STFEUTd1MlFsZ2FQd2F1cmRCRWZSUEZrbUZNMkM3MllBVmVlNUJNL2tiQUhM?=
 =?utf-8?B?by9TWFU4ekpDMEg4NDdYdEFPVEpLZVF3VXVBZnVBOXZFYUl5UzhHQkdPL3Js?=
 =?utf-8?B?VVdVMHRLeGNyNkQvYXZEVFV0MkFUaUhhMWxBaVlIN1ViUFBuREN2dUtwcExu?=
 =?utf-8?B?blFPNGdtb2hlSkRiRm9ZcmVEbmF4QUUvMlByNnB4bEhwWEJLYWlzczRJbWcv?=
 =?utf-8?B?SUtBRFM0RUZOMFF1Nkt1Tk9MQWtiR0pJZDZ2REJXOWp1Y0k4KzJBa3RLMUEx?=
 =?utf-8?B?ZkVITUhDb1FnczJMRWovME91UXh2cDdBcEpYSmlhNlp3ODJGWWU2L2s4cGxZ?=
 =?utf-8?B?cWVCZ0RKVWlka0JtZ0NPd0ZPcEgyeDkrQTdYK3pIRkFWbUtUdmp2cVZQMzlH?=
 =?utf-8?B?NSs2Wks1anFwakw2MktyK2NDQ1NYYkFENzlCNUw3NDNTY1lSZnhBZW9xNk5S?=
 =?utf-8?B?UnJLNmt6MEJqK1JHOEVsRGR5U2dqMWJhdGF5NDJaSUpkaU9aQ285NGN2eU5T?=
 =?utf-8?B?N1kwcWM5bk1tMDR5cWwwUUVkK1BjZzhBK2JZM1c2ZzBCY0c3NEVMakoxN2RL?=
 =?utf-8?B?SlpIU3o4dU1ORHBLQjZET0VMWHd4dmI5QmFEbG1QVVdwdVkwUE5TVzF3TWg4?=
 =?utf-8?B?UVljcENWS2FDSWNBNFNJWlF6bVJ4QWdZa2dubHptMnVwSURYMTMzZ2tQQXlX?=
 =?utf-8?B?V01LWVhiMC9BT2pXVHRxZjR0bElON0RoTnEyNEFYMXVXaTRzbHlGZktSVmxU?=
 =?utf-8?B?RHlFbWQrSk9QZUVHdjdwajlmKy9YT2ZqdG9Gb0Q1OU5xNFBxT3l2R3hTYjNp?=
 =?utf-8?B?QmFyeE8xZnRFd1lSVGhQbk94djFrd2srbmtTaG1QSFZ2NFlHNHBKdmx5Uk11?=
 =?utf-8?B?RUZYTlBFZmhwbHBCOTExMFBpYnZNRGVpTjZ4NTI1RHRObDhVUkRUMjNUSzhV?=
 =?utf-8?B?ZXM5b2lIMWlwQXluRG5GRHI0L2lJSjJ3TisweEF1NnpmaFBmTUJCRVRUaWhP?=
 =?utf-8?B?Y1lRRW0xVzgwOFIvajFlTTRUUGFaZEQ4TnRTYmEwVFpUay9SL0E2YzJSc2xm?=
 =?utf-8?B?NDA0QzcrZmZkQ0Z3VjkzRGFqdVpmY2VROG9VZ1pMdXRZOFppMVg4d0QvcVVu?=
 =?utf-8?B?R1pNbTlRNlQ0aWFmdTBlN3lTdGlEbis0MlV2UXhhMmFyOWNYT20rZ0hrNWsv?=
 =?utf-8?B?M0hnMXBRN1MrQk4yKy9qOWtrWEhRczJWZHJLa2N1d24rRk9ZOEZ6NXloVDZk?=
 =?utf-8?B?b0VZcC8rSUMzUEU3ODNEa0VaOXlEUCtraDNQWlptQzBHYmlmK0hYRjRaSWRn?=
 =?utf-8?B?dFJOSjJZeDJzcFBxVzFBRWQxUU9UczFMNFRYLzNmMFFWdjNrWVJ6WE1FYzZp?=
 =?utf-8?B?a1hTNXVONGdHWEhLTGp3dmJrN2c2THdFMW1SNHFiSGdnSGVEa0t0Q0x0eXNZ?=
 =?utf-8?Q?lur0Jvby6WU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUE4M0NwZWJmbGRHOXBabFlUVG5sekIyMTV1b1VyWFE2MW56L05vNXFKOG5s?=
 =?utf-8?B?SFVvOU8zRVBuRmZxSTBoYUEvRWdOVDZmbUpDKzRucW1jT25RK29KZXNrY1NL?=
 =?utf-8?B?TUd5MDVJYURXY2VmczBzajNRMFN3NWorZUQ3SnR6QWdObmlONlNkbC82SWwv?=
 =?utf-8?B?WStjK3hnWi93bGJWVmJWYjlhVUdMWEdXcmZ5YTRoOEJEZjRpbk9TQmRzWlhS?=
 =?utf-8?B?VHd4YmExT2pqc1R6MFRHeDh2UmVrZjB3dXlhYTNqOE01a0dFREZBcng5dmZQ?=
 =?utf-8?B?NVNqbCtpakcyZXAzU1pNQlhFaUtqZ0hSOEtIdkszSUE2T0Z2TUtVNmhWNFNo?=
 =?utf-8?B?MGhSdmVLZWJKUTRhM0QzZzJUK2Vqamo5VmxoMS9wRnJNdmZGdDhXd1pPdjRy?=
 =?utf-8?B?WmZYTmg3dC9uT0luMndXTjBJTGV0MU5KUFNrOExSVW00UmdnOHJZdW5YZlRw?=
 =?utf-8?B?Y3FMT0tUTm9hbmZFYUN4YldPTXd6bmJYTUUvTlM2M3JWYU94NnV5TmFHbGlt?=
 =?utf-8?B?cFZJQWY2SmYzNkpOY042ZlVJbFVVUDJzVmoxbjBmOFVRdnVyaUszTEg3T0Zh?=
 =?utf-8?B?WWI1c05pSTVwNFNTNWJXOUM5WncrVjk1cTV6VStSYmRhQTJvL2dQaTFKK3ph?=
 =?utf-8?B?Um1mcFR0Tm1xcTd4V3E0THBNZjdiNDN3aDlYZENjcHpZWU5aZHZsdFdEMElM?=
 =?utf-8?B?bXBSL21haVBicWhtSzdoZUt2K2tXTGY4NjlaZmkvcVZKaGNOcHJ4K2p5ajd6?=
 =?utf-8?B?ZHNwM1VjVE1tZ3k4L2NmNlhKdGc1Z2YzY3YzSExhUEloSm90dWlhOHA0Sm5X?=
 =?utf-8?B?akRyNkNqaU5GY0wxRlgvRG1LakVGaVdKT2Joa3BLaGRzKzQxRUwrV3luQkhu?=
 =?utf-8?B?U2ZRVXAzYzh0UUVRSHZkK1RTUG9HVmdEWmRyWlp4c01VZk1NaGpjQmtpNXlX?=
 =?utf-8?B?OFFvd2dNMEJHdmpxdHFhNHIrRGlwZW42c25uWVJKa3V0bHBXVURIQXhSTlc5?=
 =?utf-8?B?SXBMcUdYb3p1ODd6WHQydjFKbWRRSmNPMFc2MjdFU1hmcVVQUHIraUF5ZFh3?=
 =?utf-8?B?aTluMDhLR0o4UjdMTmR4ZHNjbXNTN0JXdVdOWTNPWDJZY1VMaVJRbjJEQ2Ra?=
 =?utf-8?B?dGIxNDR4Z0lodElkcnFjMVZlLzIxREYxOW4rbTBWV2d2TGtCY3FLWmNKOEdk?=
 =?utf-8?B?ZFRFYjUwSVd2VjJBV0pMa0VMb3IrdDh2Q3dxVzZ3SzQ4QXF3czdaeHluMTI0?=
 =?utf-8?B?M3JnN05SWHQ4azBmZjFyZFZHVEZ6dTJmYThOZmxyVWR4NlN2cjhCb2Nva0Rv?=
 =?utf-8?B?OTJRc1hoZmZiVGtzOGIzdnMwTlpwMDN6VjdNcUl3aDF4UFFMc2h6bVhDN0hk?=
 =?utf-8?B?NlNNb09UN2RRNnFrNUxmWFFnb3p3NEhKTlJzTHVvZE9RdHBUdVlaTk5jdWVq?=
 =?utf-8?B?S3V1dDZxam5pUVV6bmR2RFNJNUJyczBYT0U5STR2OXZQTTNXYytNRGNVVjVJ?=
 =?utf-8?B?VHhiTEdsSVVLM3JnMWZGOFFNaXB0REhVOEl4clEzcHJYZ3AvYzY1a284Ykdy?=
 =?utf-8?B?ZklEU0g2UmE5aXl5UHlMTmJPWTlQMENPcG5RNHFBUndTdmJXTWxEd0M0UHJz?=
 =?utf-8?B?c3F6RjZ5NnR3RGZLVXdlc1FmZ09EQVViZzdkb1R3VUtCSGE5RDAwdGtJUlNB?=
 =?utf-8?B?M0lQbkwwOThYMVkzNVZlSlJ0b0t1dVVvK3BHRHArcDdIYmhaQ0E4N2s0YVMz?=
 =?utf-8?B?NWlRRGhzUlVyTWwvaWlDWmkwOXNPZ2dhdVFlWTFKWVd5S3dWYWtFYWJJclJT?=
 =?utf-8?B?NE9UYjRIVnhBZm15MDdGYitjVi9WSHZoeFNxVnZPbEZweG1NWXRYcGVwRHYr?=
 =?utf-8?B?Z3gvVk0zUXdoc1lWdktFM21tWTlUcWpSSHQxMzNNamtLYWhaNjNXSkhUMUtC?=
 =?utf-8?B?K0hJMjMzWU8ycjN4ajUxTDJ2TElSOFZpOVYvUFAwNDRUWlp4UzBIV0JLaElO?=
 =?utf-8?B?YllFeXVYVGk5Nm50OE54N3pEUGVieHAvN2p5UzhURm9KUkd0S21vblgrMVF2?=
 =?utf-8?B?RzBQSnhwVU9HZXd3S2owRjNsQ1hLSmRzWjkxbHozVVJzaFZmazNBTzVXWEU3?=
 =?utf-8?B?VllkSDFEZllIS2ZhZ0FsYjkwb0xSTEdtKzZYeWxsak4vdTRJeW9rbThjU0NI?=
 =?utf-8?Q?9ySkt5hYPw5KE9EHjQ0t81JdVdX7U8bGW2YkoQjo2LDC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9169c37-20ac-426a-5334-08dd92079aec
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 10:19:12.1119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGjeHa+meDbKlFJUW4H4p8anuwL307h5IDl72SGLLQfwko6h/cHFcCgXjEecuIQ9YOwWV4FTUlucgRqcP+EcJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7246


On 12/05/2025 17:49, Conor Dooley wrote:
> On Fri, May 09, 2025 at 04:54:08PM +0000, Vishwaroop A wrote:
>> Add the 'iommus' property to the Tegra QSPI device tree binding.
>> The property is needed for Tegra234 when using the internal DMA
>> controller, and is not supported on other Tegra chips, as DMA is
>> handled by an external controller.
>>
>> Signed-off-by: Vishwaroop A <va@nvidia.com>
>> ---
>>   .../bindings/spi/nvidia,tegra210-quad.yaml    | 19 ++++++++++++++++---
>>   1 file changed, 16 insertions(+), 3 deletions(-)
>>
>> Changes since v2:
>> - Fixed version number to match the actual version
>> - Added proper changelog section
>> - No functional changes from v2
>>
>> Changes since v1:
>> - Fixed subject prefix to match subsystem (dt-bindings: spi: tegra)
>> - Improved commit message formatting to follow Linux coding style
>> - Clarified that IOMMU is only required for Tegra234 platform
>> - Added explicit disallow for IOMMU on other platforms
>> - Removed redundant explanations of what the patch does
>> - Fixed commit message to use imperative mood
>>
>> Initial Version:
>> - Initial implementation of IOMMU property documentation
>> - Added iommus property to device tree binding
>> - Added support for Tegra234 platform
>> - Added explanation of DMA and IOMMU requirements
>>
>> diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
>> index 48e97e240265..04d3b1a47392 100644
>> --- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
>> +++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
>> @@ -10,9 +10,6 @@ maintainers:
>>     - Thierry Reding <thierry.reding@gmail.com>
>>     - Jonathan Hunter <jonathanh@nvidia.com>
>>   
>> -allOf:
>> -  - $ref: spi-controller.yaml#
>> -
>>   properties:
>>     compatible:
>>       enum:
>> @@ -47,6 +44,9 @@ properties:
>>         - const: rx
>>         - const: tx
>>   
>> +  iommus:
>> +    maxItems: 1
>> +
>>   patternProperties:
>>     "@[0-9a-f]+$":
>>       type: object
>> @@ -69,6 +69,19 @@ required:
>>   
>>   unevaluatedProperties: false
>>   
>> +allOf:
>> +  - $ref: spi-controller.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          const: nvidia,tegra234-qspi
> 
>> +    then:
>> +      properties:
>> +        iommus: true
> 
> This is a NOP, no?
> Just invert the case above and drop a clause.


Yes that's true. So just to confirm, your preference is this ...

diff --git 
a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml 
b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
index 04d3b1a47392..c45511e9a9ed 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
@@ -74,11 +74,13 @@ allOf:
    - if:
        properties:
          compatible:
-          const: nvidia,tegra234-qspi
+          contains:
+            enum:
+              - nvidia,tegra210-qspi
+              - nvidia,tegra186-qspi
+              - nvidia,tegra194-qspi
+              - nvidia,tegra241-qspi
      then:
-      properties:
-        iommus: true
-    else:
        properties:
          iommus: false

Thanks!
Jon

-- 
nvpublic


